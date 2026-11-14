import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../categories/domain/entities/service_category.dart';
import '../../domain/entities/offer.dart';
import '../../domain/repositories/offer_favorites_repository.dart';
import '../../domain/repositories/offers_repository.dart';
import 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit(this._repository, this._favoritesRepository)
    : super(const OffersState()) {
    _favoriteSubscription = _favoritesRepository.favoriteIdsStream.listen(
      _handleFavoriteIdsChanged,
    );
  }

  final OffersRepository _repository;
  final OfferFavoritesRepository _favoritesRepository;
  late final StreamSubscription<Set<String>> _favoriteSubscription;

  void _handleFavoriteIdsChanged(Set<String> favoriteIds) {
    if (isClosed || setEquals(state.favoriteIds, favoriteIds)) {
      return;
    }
    emit(state.copyWith(favoriteIds: Set<String>.unmodifiable(favoriteIds)));
  }

  @override
  Future<void> close() async {
    await _favoriteSubscription.cancel();
    return super.close();
  }

  Future<void> load({bool force = false}) async {
    if (state.status == OffersStatus.loading) {
      return;
    }
    if (!force &&
        (state.status == OffersStatus.success ||
            state.status == OffersStatus.empty)) {
      return;
    }

    emit(state.copyWith(status: OffersStatus.loading, failure: null));

    try {
      final catalog = await _repository.getOffersCatalog(force: force);
      final favoriteIds = await _favoritesRepository.getFavoriteOfferIds();
      if (isClosed) {
        return;
      }

      final selectedCategoryId = _validCategoryId(
        state.selectedCategoryId,
        catalog.categories,
      );
      final allOffers = List<Offer>.unmodifiable(catalog.offers);
      final filteredOffers = _applyFilters(
        allOffers,
        query: state.query,
        categoryId: selectedCategoryId,
        sort: state.sort,
      );

      emit(
        state.copyWith(
          status: allOffers.isEmpty ? OffersStatus.empty : OffersStatus.success,
          allOffers: allOffers,
          offers: filteredOffers,
          categories: List<ServiceCategory>.unmodifiable(catalog.categories),
          selectedCategoryId: selectedCategoryId,
          favoriteIds: Set<String>.unmodifiable(favoriteIds),
          failure: null,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (error) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          status: OffersStatus.failure,
          failure: AppFailure.fromException(error),
        ),
      );
    }
  }

  Future<void> refresh() => load(force: true);

  void search(String rawQuery) {
    final query = rawQuery.trim();
    if (query == state.query) {
      return;
    }

    if (state.status != OffersStatus.success &&
        state.status != OffersStatus.empty) {
      emit(state.copyWith(query: query));
      return;
    }

    emit(
      state.copyWith(
        query: query,
        offers: _applyFilters(
          state.allOffers,
          query: query,
          categoryId: state.selectedCategoryId,
          sort: state.sort,
        ),
      ),
    );
  }

  void selectCategory(String? categoryId) {
    if (categoryId == state.selectedCategoryId) {
      return;
    }

    if (state.status != OffersStatus.success &&
        state.status != OffersStatus.empty) {
      emit(state.copyWith(selectedCategoryId: categoryId));
      return;
    }

    emit(
      state.copyWith(
        selectedCategoryId: categoryId,
        offers: _applyFilters(
          state.allOffers,
          query: state.query,
          categoryId: categoryId,
          sort: state.sort,
        ),
      ),
    );
  }

  void selectSort(OffersSort sort) {
    if (sort == state.sort) {
      return;
    }
    if (state.status != OffersStatus.success &&
        state.status != OffersStatus.empty) {
      emit(state.copyWith(sort: sort));
      return;
    }
    emit(
      state.copyWith(
        sort: sort,
        offers: _applyFilters(
          state.allOffers,
          query: state.query,
          categoryId: state.selectedCategoryId,
          sort: sort,
        ),
      ),
    );
  }

  Future<bool> toggleFavorite(String offerId) async {
    if (!state.allOffers.any((offer) => offer.id == offerId)) {
      return false;
    }

    final previousIds = state.favoriteIds;
    final wasFavorite = previousIds.contains(offerId);
    final nextIds = Set<String>.of(previousIds);
    if (wasFavorite) {
      nextIds.remove(offerId);
    } else {
      nextIds.add(offerId);
    }

    emit(
      state.copyWith(
        favoriteIds: Set<String>.unmodifiable(nextIds),
        favoriteFailure: null,
      ),
    );

    try {
      await _favoritesRepository.setFavorite(
        offerId: offerId,
        isFavorite: !wasFavorite,
      );
      return true;
    } on RequestCancelledException {
      return false;
    } catch (error) {
      if (isClosed) {
        return false;
      }
      emit(
        state.copyWith(
          favoriteIds: previousIds,
          favoriteFailure: AppFailure.fromException(error),
        ),
      );
      return false;
    }
  }

  List<Offer> _applyFilters(
    Iterable<Offer> offers, {
    required String query,
    required String? categoryId,
    required OffersSort sort,
  }) {
    final filtered = _filterOffers(
      offers,
      query: query,
      categoryId: categoryId,
    ).toList();
    _sortOffers(filtered, sort);
    return List<Offer>.unmodifiable(filtered);
  }

  List<Offer> _filterOffers(
    Iterable<Offer> offers, {
    required String query,
    required String? categoryId,
  }) {
    final normalizedQuery = query.toLowerCase();
    return offers
        .where((offer) {
          if (categoryId != null && offer.categoryId != categoryId) {
            return false;
          }
          if (normalizedQuery.isEmpty) {
            return true;
          }
          return offer.title.toLowerCase().contains(normalizedQuery) ||
              offer.businessName.toLowerCase().contains(normalizedQuery) ||
              offer.description.toLowerCase().contains(normalizedQuery);
        })
        .toList(growable: false);
  }

  void _sortOffers(List<Offer> offers, OffersSort sort) {
    switch (sort) {
      case OffersSort.recommended:
        return;
      case OffersSort.priceLowHigh:
        offers.sort((a, b) => a.price.compareTo(b.price));
        return;
      case OffersSort.priceHighLow:
        offers.sort((a, b) => b.price.compareTo(a.price));
        return;
      case OffersSort.highestDiscount:
        offers.sort(
          (a, b) => (b.discountPercent ?? 0).compareTo(a.discountPercent ?? 0),
        );
        return;
      case OffersSort.mostViewed:
        offers.sort((a, b) => b.views.compareTo(a.views));
        return;
    }
  }

  String? _validCategoryId(
    String? categoryId,
    List<ServiceCategory> categories,
  ) {
    if (categoryId == null) {
      return null;
    }
    return categories.any((category) => category.id == categoryId)
        ? categoryId
        : null;
  }
}
