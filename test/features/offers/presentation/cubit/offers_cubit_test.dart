import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/core/errors/failures.dart';
import 'package:dikirnis_stor/features/categories/domain/entities/service_category.dart';
import 'package:dikirnis_stor/features/offers/domain/entities/offer.dart';
import 'package:dikirnis_stor/features/offers/domain/entities/offer_seller.dart';
import 'package:dikirnis_stor/features/offers/domain/entities/offers_catalog.dart';
import 'package:dikirnis_stor/features/offers/data/repositories/in_memory_offer_favorites_repository.dart';
import 'package:dikirnis_stor/features/offers/domain/repositories/offer_favorites_repository.dart';
import 'package:dikirnis_stor/features/offers/domain/repositories/offers_repository.dart';
import 'package:dikirnis_stor/features/offers/presentation/cubit/offers_cubit.dart';
import 'package:dikirnis_stor/features/offers/presentation/cubit/offers_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOffersRepository extends Mock implements OffersRepository {}

class MockOfferFavoritesRepository extends Mock
    implements OfferFavoritesRepository {}

const _categories = [
  ServiceCategory(
    id: 'education',
    nameAr: 'تعليم وتدريب',
    nameEn: 'Education & training',
    iconKey: 'education',
    providersCount: 0,
  ),
  ServiceCategory(
    id: 'restaurants',
    nameAr: 'المطاعم والكافيهات',
    nameEn: 'Restaurants & cafes',
    iconKey: 'restaurant',
    providersCount: 0,
  ),
];

const _offers = [
  Offer(
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
  ),
  Offer(
    id: 'offer_food',
    businessName: 'East Grill',
    title: 'Family Meal',
    description: 'Grilled food for the whole family',
    image: 'assets/images/businesses/grill.jpg',
    categoryId: 'restaurants',
    price: 298,
    originalPrice: 350,
    discountPercent: 15,
    views: 200,
    seller: OfferSeller(id: 'seller_grill', name: 'East Grill'),
  ),
  Offer(
    id: 'offer_coffee',
    businessName: 'Cafe Lounge',
    title: 'Coffee Drinks',
    description: 'Cold coffee and fresh pastries',
    image: 'assets/images/businesses/cafe.jpg',
    categoryId: 'restaurants',
    price: 225,
    originalPrice: 250,
    discountPercent: 10,
    views: 50,
    seller: OfferSeller(id: 'seller_cafe', name: 'Cafe Lounge'),
  ),
];

const _catalog = OffersCatalog(categories: _categories, offers: _offers);

void main() {
  late MockOffersRepository repository;
  late MockOfferFavoritesRepository favoritesRepository;

  setUp(() {
    repository = MockOffersRepository();
    favoritesRepository = MockOfferFavoritesRepository();
    when(
      () => repository.getOffersCatalog(force: any(named: 'force')),
    ).thenAnswer((_) async => _catalog);
    when(
      () => favoritesRepository.getFavoriteOfferIds(),
    ).thenAnswer((_) async => <String>{});
    when(
      () => favoritesRepository.favoriteIdsStream,
    ).thenAnswer((_) => const Stream<Set<String>>.empty());
  });

  blocTest<OffersCubit, OffersState>(
    'emits loading then success with catalog and favorites',
    build: () {
      when(
        () => favoritesRepository.getFavoriteOfferIds(),
      ).thenAnswer((_) async => {'offer_web'});
      return OffersCubit(repository, favoritesRepository);
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const OffersState(status: OffersStatus.loading),
      const OffersState(
        status: OffersStatus.success,
        allOffers: _offers,
        offers: _offers,
        categories: _categories,
        favoriteIds: {'offer_web'},
      ),
    ],
    verify: (_) {
      verify(
        () => repository.getOffersCatalog(force: any(named: 'force')),
      ).called(1);
      verify(() => favoritesRepository.getFavoriteOfferIds()).called(1);
    },
  );

  test('maps loading errors to an application failure', () async {
    when(
      () => repository.getOffersCatalog(force: any(named: 'force')),
    ).thenThrow(NetworkException());

    final cubit = OffersCubit(repository, favoritesRepository);
    final states = <OffersState>[];
    final subscription = cubit.stream.listen(states.add);

    await cubit.load();
    await Future<void>.delayed(Duration.zero);

    expect(states.map((state) => state.status), [
      OffersStatus.loading,
      OffersStatus.failure,
    ]);
    expect(states.last.failure?.type, FailureType.network);
    expect(states.last.offers, isEmpty);

    await subscription.cancel();
    await cubit.close();
  });

  test('filters by query and category while preserving both', () async {
    final cubit = OffersCubit(repository, favoritesRepository);
    addTearDown(cubit.close);

    await cubit.load();

    cubit.search('WEB');
    expect(cubit.state.query, 'WEB');
    expect(cubit.state.offers.map((offer) => offer.id), ['offer_web']);

    cubit.search('flutter');
    expect(cubit.state.offers.map((offer) => offer.id), ['offer_web']);

    cubit.search('grill');
    expect(cubit.state.offers.map((offer) => offer.id), ['offer_food']);

    cubit.selectCategory('restaurants');
    expect(cubit.state.selectedCategoryId, 'restaurants');
    expect(cubit.state.query, 'grill');
    expect(cubit.state.offers.map((offer) => offer.id), ['offer_food']);

    cubit.search('coffee');
    expect(cubit.state.offers.map((offer) => offer.id), ['offer_coffee']);

    cubit.search('');
    expect(cubit.state.offers.map((offer) => offer.id), [
      'offer_food',
      'offer_coffee',
    ]);

    cubit.selectCategory(null);
    expect(cubit.state.offers, hasLength(_offers.length));
  });

  test('sorts offers without losing the active filters', () async {
    final cubit = OffersCubit(repository, favoritesRepository);
    addTearDown(cubit.close);

    await cubit.load();
    cubit.selectCategory('restaurants');
    cubit.selectSort(OffersSort.priceLowHigh);

    expect(cubit.state.sort, OffersSort.priceLowHigh);
    expect(cubit.state.offers.map((offer) => offer.id), [
      'offer_coffee',
      'offer_food',
    ]);

    cubit.selectSort(OffersSort.highestDiscount);
    expect(cubit.state.offers.map((offer) => offer.id), [
      'offer_food',
      'offer_coffee',
    ]);
    expect(cubit.state.selectedCategoryId, 'restaurants');
  });

  test('toggles a favorite optimistically and persists it', () async {
    when(
      () => favoritesRepository.setFavorite(
        offerId: 'offer_web',
        isFavorite: true,
      ),
    ).thenAnswer((_) async {});
    when(
      () => favoritesRepository.setFavorite(
        offerId: 'offer_web',
        isFavorite: false,
      ),
    ).thenAnswer((_) async {});

    final cubit = OffersCubit(repository, favoritesRepository);
    addTearDown(cubit.close);
    await cubit.load();

    final added = await cubit.toggleFavorite('offer_web');

    expect(added, isTrue);
    expect(cubit.state.isFavorite('offer_web'), isTrue);
    verify(
      () => favoritesRepository.setFavorite(
        offerId: 'offer_web',
        isFavorite: true,
      ),
    ).called(1);

    final removed = await cubit.toggleFavorite('offer_web');

    expect(removed, isTrue);
    expect(cubit.state.isFavorite('offer_web'), isFalse);
    verify(
      () => favoritesRepository.setFavorite(
        offerId: 'offer_web',
        isFavorite: false,
      ),
    ).called(1);
  });

  test('reflects favorites changed by another screen', () async {
    final favorites = InMemoryOfferFavoritesRepository();
    final cubit = OffersCubit(repository, favorites);
    addTearDown(cubit.close);

    await cubit.load();
    expect(cubit.state.isFavorite('offer_web'), isFalse);

    await favorites.setFavorite(offerId: 'offer_web', isFavorite: true);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.isFavorite('offer_web'), isTrue);
  });

  test('rolls back the favorite when persistence fails', () async {
    when(
      () => favoritesRepository.setFavorite(
        offerId: 'offer_web',
        isFavorite: true,
      ),
    ).thenThrow(NetworkException());

    final cubit = OffersCubit(repository, favoritesRepository);
    addTearDown(cubit.close);
    await cubit.load();

    final result = await cubit.toggleFavorite('offer_web');

    expect(result, isFalse);
    expect(cubit.state.isFavorite('offer_web'), isFalse);
    expect(cubit.state.favoriteFailure?.type, FailureType.network);
  });

  blocTest<OffersCubit, OffersState>(
    'does not reload after a successful load, but refresh does',
    build: () => OffersCubit(repository, favoritesRepository),
    act: (cubit) async {
      await cubit.load();
      await cubit.load();
      await cubit.refresh();
    },
    expect: () => [
      const OffersState(status: OffersStatus.loading),
      const OffersState(
        status: OffersStatus.success,
        allOffers: _offers,
        offers: _offers,
        categories: _categories,
      ),
      const OffersState(
        status: OffersStatus.loading,
        allOffers: _offers,
        offers: _offers,
        categories: _categories,
      ),
      const OffersState(
        status: OffersStatus.success,
        allOffers: _offers,
        offers: _offers,
        categories: _categories,
      ),
    ],
    verify: (_) {
      verify(
        () => repository.getOffersCatalog(force: any(named: 'force')),
      ).called(2);
    },
  );
}
