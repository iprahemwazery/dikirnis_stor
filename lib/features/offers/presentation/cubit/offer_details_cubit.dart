import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../categories/domain/entities/service_category.dart';
import '../../domain/entities/offer.dart';
import '../../domain/repositories/offer_favorites_repository.dart';
import '../../domain/repositories/offers_repository.dart';
import 'offer_details_state.dart';

class OfferDetailsCubit extends Cubit<OfferDetailsState> {
  OfferDetailsCubit(this._repository, this._favoritesRepository)
    : super(const OfferDetailsState()) {
    _favoriteSubscription = _favoritesRepository.favoriteIdsStream.listen(
      _handleFavoriteIdsChanged,
    );
  }

  final OffersRepository _repository;
  final OfferFavoritesRepository _favoritesRepository;
  late final StreamSubscription<Set<String>> _favoriteSubscription;

  String? _offerId;

  void _handleFavoriteIdsChanged(Set<String> favoriteIds) {
    if (isClosed) {
      return;
    }
    final offer = state.offer;
    final isFavorite = offer != null
        ? favoriteIds.contains(offer.id)
        : state.isFavorite;
    if (setEquals(state.favoriteIds, favoriteIds) &&
        isFavorite == state.isFavorite) {
      return;
    }
    emit(
      state.copyWith(
        favoriteIds: Set<String>.unmodifiable(favoriteIds),
        isFavorite: isFavorite,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _favoriteSubscription.cancel();
    return super.close();
  }

  Future<void> load(String offerId, {bool force = false}) async {
    _offerId = offerId;
    if (state.status == OfferDetailsStatus.loading) {
      return;
    }
    if (!force &&
        state.status == OfferDetailsStatus.success &&
        state.offer?.id == offerId) {
      return;
    }

    emit(state.copyWith(status: OfferDetailsStatus.loading, failure: null));

    try {
      final catalog = await _repository.getOffersCatalog();
      Offer? selectedOffer;
      for (final offer in catalog.offers) {
        if (offer.id == offerId) {
          selectedOffer = offer;
          break;
        }
      }
      if (selectedOffer == null) {
        throw const NotFoundException(
          message: 'The requested offer was not found.',
        );
      }
      final favoriteIds = await _favoritesRepository.getFavoriteOfferIds();
      if (isClosed) {
        return;
      }

      final offer = selectedOffer;
      ServiceCategory? category;
      for (final item in catalog.categories) {
        if (item.id == offer.categoryId) {
          category = item;
          break;
        }
      }
      final similarOffers = catalog.offers
          .where(
            (item) =>
                item.id != offer.id && item.categoryId == offer.categoryId,
          )
          .take(6)
          .toList(growable: false);

      emit(
        state.copyWith(
          status: OfferDetailsStatus.success,
          offer: offer,
          category: category,
          similarOffers: List<Offer>.unmodifiable(similarOffers),
          isFavorite: favoriteIds.contains(offer.id),
          favoriteIds: Set<String>.unmodifiable(favoriteIds),
          failure: null,
        ),
      );
    } catch (error) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          status: OfferDetailsStatus.failure,
          failure: AppFailure.fromException(error),
        ),
      );
    }
  }

  Future<void> retry() async {
    final offerId = _offerId;
    if (offerId == null) {
      return;
    }
    await load(offerId, force: true);
  }

  Future<bool> toggleFavorite() async {
    final offer = state.offer;
    if (offer == null) {
      return false;
    }

    final wasFavorite = state.isFavorite;
    final previousIds = state.favoriteIds;
    final nextIds = Set<String>.of(previousIds);
    if (wasFavorite) {
      nextIds.remove(offer.id);
    } else {
      nextIds.add(offer.id);
    }
    emit(
      state.copyWith(
        isFavorite: !wasFavorite,
        favoriteIds: Set<String>.unmodifiable(nextIds),
        favoriteFailure: null,
      ),
    );

    try {
      await _favoritesRepository.setFavorite(
        offerId: offer.id,
        isFavorite: !wasFavorite,
      );
      return true;
    } catch (error) {
      if (isClosed) {
        return false;
      }
      emit(
        state.copyWith(
          isFavorite: wasFavorite,
          favoriteIds: previousIds,
          favoriteFailure: AppFailure.fromException(error),
        ),
      );
      return false;
    }
  }

  Future<bool> toggleFavoriteFor(String offerId) async {
    if (offerId == state.offer?.id) {
      return toggleFavorite();
    }
    if (!state.similarOffers.any((offer) => offer.id == offerId)) {
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
}
