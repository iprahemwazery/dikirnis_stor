import 'package:dikirnis_stor/features/offers/data/repositories/shared_preferences_offer_favorites_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('restores favorites and persists updates', () async {
    SharedPreferences.setMockInitialValues({
      'offers.favorite_ids': ['offer_a'],
    });
    final preferences = await SharedPreferences.getInstance();
    final repository = SharedPreferencesOfferFavoritesRepository(preferences);

    expect(await repository.getFavoriteOfferIds(), {'offer_a'});

    final updates = <Set<String>>[];
    final subscription = repository.favoriteIdsStream.listen(updates.add);
    await repository.setFavorite(offerId: 'offer_b', isFavorite: true);
    await repository.setFavorite(offerId: 'offer_a', isFavorite: false);

    expect(await repository.getFavoriteOfferIds(), {'offer_b'});
    expect(updates, [
      {'offer_a', 'offer_b'},
      {'offer_b'},
    ]);

    final restored = SharedPreferencesOfferFavoritesRepository(preferences);
    expect(await restored.getFavoriteOfferIds(), {'offer_b'});

    await subscription.cancel();
  });
}
