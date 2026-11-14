import 'dart:async';

import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/features/categories/data/models/category_model.dart';
import 'package:dikirnis_stor/features/offers/data/datasources/offers_data_source.dart';
import 'package:dikirnis_stor/features/offers/data/models/offer_model.dart';
import 'package:dikirnis_stor/features/offers/data/models/offer_seller_model.dart';
import 'package:dikirnis_stor/features/offers/data/models/offers_content_model.dart';
import 'package:dikirnis_stor/features/offers/data/repositories/offers_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOffersDataSource extends Mock implements OffersDataSource {}

final _model = OffersContentModel(
  categories: const [
    CategoryModel(
      id: 'education',
      nameAr: 'تعليم وتدريب',
      nameEn: 'Education & training',
      iconKey: 'education',
    ),
    CategoryModel(
      id: 'restaurants',
      nameAr: 'المطاعم والكافيهات',
      nameEn: 'Restaurants & cafes',
      iconKey: 'restaurant',
    ),
  ],
  offers: [
    OfferModel(
      id: 'offer_techno_training',
      businessName: 'مركز تكنو للتدريب',
      title: 'خصم 40% على دورات البرمجة',
      description: 'دورات عملية في تطوير الويب.',
      image: 'assets/images/businesses/electronics.jpg',
      categoryId: 'education',
      price: 900,
      originalPrice: 1500,
      seller: const OfferSellerModel(
        id: 'seller_techno_training',
        name: 'مركز تكنو للتدريب',
        isVerified: true,
      ),
      discountPercent: 40,
      expiresAt: DateTime(2026, 12, 31),
      views: 286,
      isFeatured: true,
    ),
    const OfferModel(
      id: 'offer_east_grill',
      businessName: 'مشويات الشرق',
      title: 'خصم 15% على الوجبات العائلية',
      description: 'وجبات مشويات على الفحم.',
      image: 'assets/images/businesses/grill.jpg',
      categoryId: 'restaurants',
      price: 298,
      seller: OfferSellerModel(id: 'seller_east_grill', name: 'مشويات الشرق'),
      discountPercent: 15,
      views: 312,
    ),
  ],
);

void main() {
  late MockOffersDataSource dataSource;
  late OffersRepositoryImpl repository;

  setUp(() {
    dataSource = MockOffersDataSource();
    repository = OffersRepositoryImpl(dataSource);
  });

  test('maps the data-source model to a domain catalog', () async {
    when(() => dataSource.fetchOffersCatalog()).thenAnswer((_) async => _model);

    final catalog = await repository.getOffersCatalog();

    expect(catalog.categories, hasLength(2));
    expect(catalog.categories.first.id, 'education');
    expect(catalog.offers, hasLength(2));
    expect(catalog.offers.first.businessName, 'مركز تكنو للتدريب');
    expect(catalog.offers.first.hasDiscount, isTrue);
    expect(catalog.offers.first.price, 900);
    expect(catalog.offers.first.seller.isVerified, isTrue);
    verify(() => dataSource.fetchOffersCatalog()).called(1);
  });

  test('finds an offer by id', () async {
    when(() => dataSource.fetchOffersCatalog()).thenAnswer((_) async => _model);

    final offer = await repository.getOfferById('offer_east_grill');

    expect(offer.businessName, 'مشويات الشرق');
    expect(offer.categoryId, 'restaurants');
  });

  test('throws NotFoundException for an unknown offer id', () async {
    when(() => dataSource.fetchOffersCatalog()).thenAnswer((_) async => _model);

    await expectLater(
      repository.getOfferById('missing'),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('rethrows application exceptions unchanged', () async {
    when(
      () => dataSource.fetchOffersCatalog(),
    ).thenThrow(const ParsingException());

    await expectLater(
      repository.getOffersCatalog(),
      throwsA(isA<ParsingException>()),
    );
  });

  test('wraps unexpected errors in UnknownException', () async {
    when(() => dataSource.fetchOffersCatalog()).thenThrow(StateError('boom'));

    await expectLater(
      repository.getOffersCatalog(),
      throwsA(isA<UnknownException>()),
    );
  });

  test('caches the catalog within the TTL and refreshes when forced', () async {
    var fetchCount = 0;
    when(() => dataSource.fetchOffersCatalog()).thenAnswer((_) async {
      fetchCount++;
      return _model;
    });

    await repository.getOffersCatalog();
    await repository.getOffersCatalog();
    expect(fetchCount, 1);

    await repository.getOffersCatalog(force: true);
    expect(fetchCount, 2);
  });

  test('deduplicates concurrent catalog requests', () async {
    final completer = Completer<OffersContentModel>();
    when(
      () => dataSource.fetchOffersCatalog(),
    ).thenAnswer((_) => completer.future);

    final first = repository.getOffersCatalog();
    final second = repository.getOffersCatalog();

    expect(identical(first, second), isTrue);
    completer.complete(_model);
    await Future.wait([first, second]);
    verify(() => dataSource.fetchOffersCatalog()).called(1);
  });

  test('returns the last cached catalog when a refresh is offline', () async {
    when(() => dataSource.fetchOffersCatalog()).thenAnswer((_) async => _model);
    final cached = await repository.getOffersCatalog();

    when(
      () => dataSource.fetchOffersCatalog(),
    ).thenThrow(const NetworkException());

    final fallback = await repository.getOffersCatalog(force: true);

    expect(fallback, same(cached));
    verify(() => dataSource.fetchOffersCatalog()).called(2);
  });
}
