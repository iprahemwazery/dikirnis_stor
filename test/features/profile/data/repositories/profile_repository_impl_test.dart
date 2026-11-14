import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/features/profile/data/datasources/profile_data_source.dart';
import 'package:dikirnis_stor/features/profile/data/models/profile_model.dart';
import 'package:dikirnis_stor/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileDataSource extends Mock implements ProfileDataSource {}

const _model = ProfileModel(
  name: 'أحمد محمود',
  location: 'دكرنس، الدقهلية',
  memberSince: '2024',
  ordersCount: 12,
  favoritesCount: 8,
  reviewsCount: 5,
);

void main() {
  late MockProfileDataSource dataSource;
  late ProfileRepositoryImpl repository;

  setUp(() {
    dataSource = MockProfileDataSource();
    repository = ProfileRepositoryImpl(dataSource);
  });

  test('maps the data-source model to a domain entity', () async {
    when(() => dataSource.fetchProfile()).thenAnswer((_) async => _model);

    final profile = await repository.getProfile();

    expect(profile.name, 'أحمد محمود');
    expect(profile.ordersCount, 12);
    verify(() => dataSource.fetchProfile()).called(1);
  });

  test('rethrows application exceptions unchanged', () async {
    when(() => dataSource.fetchProfile()).thenThrow(const ParsingException());

    await expectLater(
      repository.getProfile(),
      throwsA(isA<ParsingException>()),
    );
  });

  test('wraps unexpected errors in UnknownException', () async {
    when(() => dataSource.fetchProfile()).thenThrow(StateError('boom'));

    await expectLater(
      repository.getProfile(),
      throwsA(isA<UnknownException>()),
    );
  });
}
