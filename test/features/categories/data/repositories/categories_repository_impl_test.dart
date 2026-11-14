import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/features/categories/data/datasources/categories_data_source.dart';
import 'package:dikirnis_stor/features/categories/data/models/category_model.dart';
import 'package:dikirnis_stor/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:dikirnis_stor/features/categories/domain/entities/service_category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoriesDataSource extends Mock implements CategoriesDataSource {}

void main() {
  late MockCategoriesDataSource dataSource;
  late CategoriesRepositoryImpl repository;

  setUp(() {
    dataSource = MockCategoriesDataSource();
    repository = CategoriesRepositoryImpl(dataSource);
  });

  test('maps data models to domain entities', () async {
    when(() => dataSource.fetchCategories()).thenAnswer(
      (_) async => const [
        CategoryModel(
          id: 'pharmacy',
          nameAr: 'صيدليات',
          nameEn: 'Pharmacies',
          iconKey: 'pharmacy',
          providersCount: 12,
        ),
      ],
    );

    final result = await repository.getCategories();

    expect(result, const [
      ServiceCategory(
        id: 'pharmacy',
        nameAr: 'صيدليات',
        nameEn: 'Pharmacies',
        iconKey: 'pharmacy',
        providersCount: 12,
      ),
    ]);
  });

  test('preserves application exceptions from the data source', () async {
    when(
      () => dataSource.fetchCategories(),
    ).thenThrow(const NetworkException());

    await expectLater(
      repository.getCategories(),
      throwsA(isA<NetworkException>()),
    );
  });

  test('wraps unexpected errors in an UnknownException', () async {
    when(
      () => dataSource.fetchCategories(),
    ).thenThrow(StateError('unexpected'));

    await expectLater(
      repository.getCategories(),
      throwsA(isA<UnknownException>()),
    );
  });
}
