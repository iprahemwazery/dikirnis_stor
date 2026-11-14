import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../categories/domain/entities/service_category.dart';
import '../../domain/entities/offer.dart';

enum OffersStatus { initial, loading, success, empty, failure }

enum OffersSort {
  recommended,
  priceLowHigh,
  priceHighLow,
  highestDiscount,
  mostViewed,
}

const Object _unset = Object();

class OffersState extends Equatable {
  const OffersState({
    this.status = OffersStatus.initial,
    this.allOffers = const [],
    this.offers = const [],
    this.categories = const [],
    this.query = '',
    this.selectedCategoryId,
    this.sort = OffersSort.recommended,
    this.favoriteIds = const {},
    this.failure,
    this.favoriteFailure,
  });

  final OffersStatus status;
  final List<Offer> allOffers;
  final List<Offer> offers;
  final List<ServiceCategory> categories;
  final String query;
  final String? selectedCategoryId;
  final OffersSort sort;
  final Set<String> favoriteIds;
  final AppFailure? failure;
  final AppFailure? favoriteFailure;

  bool get isSearching => query.isNotEmpty;

  bool isFavorite(String offerId) => favoriteIds.contains(offerId);

  OffersState copyWith({
    OffersStatus? status,
    List<Offer>? allOffers,
    List<Offer>? offers,
    List<ServiceCategory>? categories,
    String? query,
    Object? selectedCategoryId = _unset,
    OffersSort? sort,
    Set<String>? favoriteIds,
    Object? failure = _unset,
    Object? favoriteFailure = _unset,
  }) {
    return OffersState(
      status: status ?? this.status,
      allOffers: allOffers ?? this.allOffers,
      offers: offers ?? this.offers,
      categories: categories ?? this.categories,
      query: query ?? this.query,
      selectedCategoryId: identical(selectedCategoryId, _unset)
          ? this.selectedCategoryId
          : selectedCategoryId as String?,
      sort: sort ?? this.sort,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      failure: identical(failure, _unset)
          ? this.failure
          : failure as AppFailure?,
      favoriteFailure: identical(favoriteFailure, _unset)
          ? this.favoriteFailure
          : favoriteFailure as AppFailure?,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allOffers,
    offers,
    categories,
    query,
    selectedCategoryId,
    sort,
    favoriteIds,
    failure,
    favoriteFailure,
  ];
}
