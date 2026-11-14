import 'dart:async';

import '../../domain/repositories/offer_favorites_repository.dart';

class InMemoryOfferFavoritesRepository implements OfferFavoritesRepository {
  final Set<String> _favoriteIds = {};
  final StreamController<Set<String>> _favoriteIdsController =
      StreamController<Set<String>>.broadcast();

  @override
  Stream<Set<String>> get favoriteIdsStream => _favoriteIdsController.stream;

  @override
  Future<Set<String>> getFavoriteOfferIds() async {
    return Set<String>.unmodifiable(_favoriteIds);
  }

  @override
  Future<void> setFavorite({
    required String offerId,
    required bool isFavorite,
  }) async {
    if (isFavorite) {
      _favoriteIds.add(offerId);
    } else {
      _favoriteIds.remove(offerId);
    }
    _favoriteIdsController.add(Set<String>.unmodifiable(_favoriteIds));
  }
}
