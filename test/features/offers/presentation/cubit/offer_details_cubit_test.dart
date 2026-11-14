import 'package:bloc_test/bloc_test.dart';
import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/core/errors/failures.dart';
import 'package:dikirnis_stor/features/categories/domain/entities/service_category.dart';
import 'package:dikirnis_stor/features/offers/data/repositories/in_memory_offer_favorites_repository.dart';
import 'package:dikirnis_stor/features/offers/domain/entities/offer.dart';
import 'package:dikirnis_stor/features/offers/domain/entities/offer_seller.dart';
import 'package:dikirnis_stor/features/offers/domain/entities/offers_catalog.dart';
import 'package:dikirnis_stor/features/offers/domain/repositories/offer_favorites_repository.dart';
import 'package:dikirnis_stor/features/offers/domain/repositories/offers_repository.dart';
import 'package:dikirnis_stor/features/offers/presentation/cubit/offer_details_cubit.dart';
import 'package:dikirnis_stor/features/offers/presentation/cubit/offer_details_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOffersRepository extends Mock implements OffersRepository {}

class MockOfferFavoritesRepository extends Mock
    implements OfferFavoritesRepository {}

const _category = ServiceCategory(
  id: 'education',
  nameAr: 'تعليم وتدريب',
  nameEn: 'Education & training',
  iconKey: 'education',
  providersCount: 0,
);

const _categories = [_category];

const _offer = Offer(
  id: 'offer_web',
  businessName: 'Techno Center',
  title: 'Web Development Course',
  description: 'Learn Flutter and Dart',
  image: 'assets/images/businesses/electronics.jpg',
  categoryId: 'education',
  price: 900,
  originalPrice: 1500,
  discountPercent: 40,
  views: 100,
  isFeatured: true,
  seller: OfferSeller(
    id: 'seller_techno',
    name: 'Techno Center',
    isVerified: true,
  ),
);

const _similarOffer = Offer(
  id: 'offer_ui',
  businessName: 'Techno Center',
  title: 'UI Design Course',
  description: 'Learn product design',
  image: 'assets/images/businesses/lab.jpg',
  categoryId: 'education',
  price: 600,
  discountPercent: 20,
  views: 50,
  seller: OfferSeller(id: 'seller_techno', name: 'Techno Center'),
);

const _catalog = OffersCatalog(
  categories: _categories,
  offers: [_offer, _similarOffer],
);

void main() {
  late MockOffersRepository repository;
  late MockOfferFavoritesRepository favoritesRepository;

  setUp(() {
    repository = MockOffersRepository();
    favoritesRepository = MockOfferFavoritesRepository();
    when(() => repository.getOffersCatalog()).thenAnswer((_) async => _catalog);
    when(
      () => favoritesRepository.getFavoriteOfferIds(),
    ).thenAnswer((_) async => {'offer_web'});
    when(
      () => favoritesRepository.favoriteIdsStream,
    ).thenAnswer((_) => const Stream<Set<String>>.empty());
  });

  blocTest<OfferDetailsCubit, OfferDetailsState>(
    'emits loading then success with category, similar offers, and favorite',
    build: () => OfferDetailsCubit(repository, favoritesRepository),
    act: (cubit) => cubit.load('offer_web'),
    expect: () => [
      const OfferDetailsState(status: OfferDetailsStatus.loading),
      const OfferDetailsState(
        status: OfferDetailsStatus.success,
        offer: _offer,
        category: _category,
        similarOffers: [_similarOffer],
        isFavorite: true,
        favoriteIds: {'offer_web'},
      ),
    ],
    verify: (_) {
      verify(() => repository.getOffersCatalog()).called(1);
      verify(() => favoritesRepository.getFavoriteOfferIds()).called(1);
    },
  );

  test('maps a missing offer to a not-found failure', () async {
    final cubit = OfferDetailsCubit(repository, favoritesRepository);
    final states = <OfferDetailsState>[];
    final subscription = cubit.stream.listen(states.add);

    await cubit.load('missing');
    await Future<void>.delayed(Duration.zero);

    expect(states.map((state) => state.status), [
      OfferDetailsStatus.loading,
      OfferDetailsStatus.failure,
    ]);
    expect(states.last.failure?.type, FailureType.notFound);

    await subscription.cancel();
    await cubit.close();
  });

  test('toggles the favorite and rolls back on failure', () async {
    when(
      () => favoritesRepository.setFavorite(
        offerId: 'offer_web',
        isFavorite: false,
      ),
    ).thenAnswer((_) async {});
    when(
      () => favoritesRepository.setFavorite(
        offerId: 'offer_web',
        isFavorite: true,
      ),
    ).thenThrow(NetworkException());

    final cubit = OfferDetailsCubit(repository, favoritesRepository);
    addTearDown(cubit.close);
    await cubit.load('offer_web');

    final removed = await cubit.toggleFavorite();

    expect(removed, isTrue);
    expect(cubit.state.isFavorite, isFalse);
    expect(cubit.state.isFavoriteFor('offer_web'), isFalse);
    verify(
      () => favoritesRepository.setFavorite(
        offerId: 'offer_web',
        isFavorite: false,
      ),
    ).called(1);

    final reAdded = await cubit.toggleFavorite();

    expect(reAdded, isFalse);
    expect(cubit.state.isFavorite, isFalse);
    expect(cubit.state.favoriteFailure?.type, FailureType.network);
  });

  test('toggles a similar offer favorite independently', () async {
    when(
      () => favoritesRepository.setFavorite(
        offerId: 'offer_ui',
        isFavorite: true,
      ),
    ).thenAnswer((_) async {});

    final cubit = OfferDetailsCubit(repository, favoritesRepository);
    addTearDown(cubit.close);
    await cubit.load('offer_web');

    final result = await cubit.toggleFavoriteFor('offer_ui');

    expect(result, isTrue);
    expect(cubit.state.isFavoriteFor('offer_ui'), isTrue);
    expect(cubit.state.isFavorite, isTrue);
  });

  test('reflects favorites changed by another screen', () async {
    final favorites = InMemoryOfferFavoritesRepository();
    await favorites.setFavorite(offerId: 'offer_web', isFavorite: true);
    final cubit = OfferDetailsCubit(repository, favorites);
    addTearDown(cubit.close);

    await cubit.load('offer_web');
    expect(cubit.state.isFavorite, isTrue);

    await favorites.setFavorite(offerId: 'offer_web', isFavorite: false);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.isFavorite, isFalse);
  });

  test('retry reloads the last requested offer', () async {
    final cubit = OfferDetailsCubit(repository, favoritesRepository);
    addTearDown(cubit.close);

    await cubit.load('offer_web');
    await cubit.retry();

    verify(() => repository.getOffersCatalog()).called(2);
  });
}
