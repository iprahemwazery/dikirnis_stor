import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/core/errors/failures.dart';
import 'package:dikirnis_stor/features/categories/domain/entities/service_category.dart';
import 'package:dikirnis_stor/features/categories/domain/repositories/categories_repository.dart';
import 'package:dikirnis_stor/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:dikirnis_stor/features/categories/presentation/cubit/categories_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoriesRepository extends Mock implements CategoriesRepository {}

const _restaurants = ServiceCategory(
  id: 'restaurants',
  nameAr: 'مطاعم',
  nameEn: 'Restaurants',
  iconKey: 'restaurant',
  providersCount: 24,
);

const _pharmacies = ServiceCategory(
  id: 'pharmacy',
  nameAr: 'صيدليات',
  nameEn: 'Pharmacies',
  iconKey: 'pharmacy',
  providersCount: 12,
);

const _categories = <ServiceCategory>[_restaurants, _pharmacies];

void main() {
  late MockCategoriesRepository repository;

  setUp(() {
    repository = MockCategoriesRepository();
  });

  blocTest<CategoriesCubit, CategoriesState>(
    'emits loading then success when categories are loaded',
    build: () {
      when(
        () => repository.getCategories(),
      ).thenAnswer((_) async => _categories);
      return CategoriesCubit(repository);
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const CategoriesState(status: CategoriesStatus.loading),
      const CategoriesState(
        status: CategoriesStatus.success,
        allCategories: _categories,
        categories: _categories,
      ),
    ],
    verify: (_) {
      verify(() => repository.getCategories()).called(1);
    },
  );

  blocTest<CategoriesCubit, CategoriesState>(
    'emits empty when the repository returns no categories',
    build: () {
      when(() => repository.getCategories()).thenAnswer((_) async => const []);
      return CategoriesCubit(repository);
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const CategoriesState(status: CategoriesStatus.loading),
      const CategoriesState(status: CategoriesStatus.empty),
    ],
  );

  blocTest<CategoriesCubit, CategoriesState>(
    'emits failure with a mapped AppFailure when loading fails',
    build: () {
      when(
        () => repository.getCategories(),
      ).thenThrow(const NetworkException());
      return CategoriesCubit(repository);
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const CategoriesState(status: CategoriesStatus.loading),
      isA<CategoriesState>()
          .having((state) => state.status, 'status', CategoriesStatus.failure)
          .having(
            (state) => state.failure?.type,
            'failure type',
            FailureType.network,
          ),
    ],
  );

  blocTest<CategoriesCubit, CategoriesState>(
    'filters categories by English name',
    build: () {
      when(
        () => repository.getCategories(),
      ).thenAnswer((_) async => _categories);
      return CategoriesCubit(repository);
    },
    act: (cubit) async {
      await cubit.load();
      cubit.search('pharm');
    },
    skip: 2,
    expect: () => [
      const CategoriesState(
        status: CategoriesStatus.success,
        allCategories: _categories,
        categories: [_pharmacies],
        query: 'pharm',
      ),
    ],
  );

  blocTest<CategoriesCubit, CategoriesState>(
    'filters categories by Arabic name',
    build: () {
      when(
        () => repository.getCategories(),
      ).thenAnswer((_) async => _categories);
      return CategoriesCubit(repository);
    },
    act: (cubit) async {
      await cubit.load();
      cubit.search('مطاعم');
    },
    skip: 2,
    expect: () => [
      const CategoriesState(
        status: CategoriesStatus.success,
        allCategories: _categories,
        categories: [_restaurants],
        query: 'مطاعم',
      ),
    ],
  );

  test('does not start a second request while one is in flight', () async {
    final completer = Completer<List<ServiceCategory>>();
    when(() => repository.getCategories()).thenAnswer((_) => completer.future);

    final cubit = CategoriesCubit(repository);
    final firstLoad = cubit.load();
    final secondLoad = cubit.load();

    completer.complete(_categories);
    await Future.wait([firstLoad, secondLoad]);

    verify(() => repository.getCategories()).called(1);
    expect(cubit.state.status, CategoriesStatus.success);
    expect(cubit.state.categories, _categories);

    await cubit.close();
  });
}
