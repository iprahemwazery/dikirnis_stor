import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/offer_favorites_repository.dart';

class SharedPreferencesOfferFavoritesRepository
    implements OfferFavoritesRepository {
  SharedPreferencesOfferFavoritesRepository(this._preferences)
    : _favoriteIds = {...?_preferences.getStringList(_favoritesKey)?.toSet()};

  static const String _favoritesKey = 'offers.favorite_ids';

  final SharedPreferences _preferences;
  final Set<String> _favoriteIds;
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
    final previousIds = Set<String>.of(_favoriteIds);
    if (isFavorite) {
      _favoriteIds.add(offerId);
    } else {
      _favoriteIds.remove(offerId);
    }

    final didSave = await _preferences.setStringList(
      _favoritesKey,
      _favoriteIds.toList(growable: false)..sort(),
    );
    if (!didSave) {
      _favoriteIds
        ..clear()
        ..addAll(previousIds);
      throw StateError('Could not persist the favorite change.');
    }
    _favoriteIdsController.add(Set<String>.unmodifiable(_favoriteIds));
  }
}
