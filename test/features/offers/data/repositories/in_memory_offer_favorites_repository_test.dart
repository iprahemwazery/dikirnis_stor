import 'package:dikirnis_stor/features/offers/data/repositories/in_memory_offer_favorites_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('stores favorites and emits updates', () async {
    final repository = InMemoryOfferFavoritesRepository();
    final emissions = <Set<String>>[];
    final subscription = repository.favoriteIdsStream.listen(emissions.add);

    expect(await repository.getFavoriteOfferIds(), isEmpty);

    await repository.setFavorite(offerId: 'offer_1', isFavorite: true);
    await repository.setFavorite(offerId: 'offer_2', isFavorite: true);
    await repository.setFavorite(offerId: 'offer_1', isFavorite: false);
    await Future<void>.delayed(Duration.zero);

    expect(await repository.getFavoriteOfferIds(), {'offer_2'});
    expect(emissions, [
      {'offer_1'},
      {'offer_1', 'offer_2'},
      {'offer_2'},
    ]);

    await subscription.cancel();
  });
}
