import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../categories/domain/entities/service_category.dart';
import '../../domain/entities/offer.dart';

enum OfferDetailsStatus { initial, loading, success, failure }

const Object _unset = Object();

class OfferDetailsState extends Equatable {
  const OfferDetailsState({
    this.status = OfferDetailsStatus.initial,
    this.offer,
    this.category,
    this.similarOffers = const [],
    this.isFavorite = false,
    this.favoriteIds = const {},
    this.failure,
    this.favoriteFailure,
  });

  final OfferDetailsStatus status;
  final Offer? offer;
  final ServiceCategory? category;
  final List<Offer> similarOffers;
  final bool isFavorite;
  final Set<String> favoriteIds;
  final AppFailure? failure;
  final AppFailure? favoriteFailure;

  bool isFavoriteFor(String offerId) => favoriteIds.contains(offerId);

  OfferDetailsState copyWith({
    OfferDetailsStatus? status,
    Object? offer = _unset,
    Object? category = _unset,
    List<Offer>? similarOffers,
    bool? isFavorite,
    Set<String>? favoriteIds,
    Object? failure = _unset,
    Object? favoriteFailure = _unset,
  }) {
    return OfferDetailsState(
      status: status ?? this.status,
      offer: identical(offer, _unset) ? this.offer : offer as Offer?,
      category: identical(category, _unset)
          ? this.category
          : category as ServiceCategory?,
      similarOffers: similarOffers ?? this.similarOffers,
      isFavorite: isFavorite ?? this.isFavorite,
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
    offer,
    category,
    similarOffers,
    isFavorite,
    favoriteIds,
    failure,
    favoriteFailure,
  ];
}
