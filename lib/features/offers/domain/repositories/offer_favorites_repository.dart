abstract interface class OfferFavoritesRepository {
  Stream<Set<String>> get favoriteIdsStream;

  Future<Set<String>> getFavoriteOfferIds();

  Future<void> setFavorite({required String offerId, required bool isFavorite});
}
