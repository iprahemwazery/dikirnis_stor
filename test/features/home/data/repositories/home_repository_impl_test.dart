import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/features/home/data/datasources/home_data_source.dart';
import 'package:dikirnis_stor/features/home/data/models/home_content_model.dart';
import 'package:dikirnis_stor/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeDataSource extends Mock implements HomeDataSource {}

const _model = HomeContentModel(
  userName: 'أحمد محمود',
  userLocation: 'دكرنس، الدقهلية',
  banners: [],
  categories: [],
  mostViewed: [],
  recentlyAdded: [],
  medical: [],
  restaurants: [],
);

void main() {
  late MockHomeDataSource dataSource;
  late HomeRepositoryImpl repository;

  setUp(() {
    dataSource = MockHomeDataSource();
    repository = HomeRepositoryImpl(dataSource);
  });

  test('maps the data-source model to a domain entity', () async {
    when(() => dataSource.fetchHomeContent()).thenAnswer((_) async => _model);

    final content = await repository.getHomeContent();

    expect(content.userName, 'أحمد محمود');
    expect(content.userLocation, 'دكرنس، الدقهلية');
    expect(content.isEmpty, isTrue);
    verify(() => dataSource.fetchHomeContent()).called(1);
  });

  test('rethrows application exceptions unchanged', () async {
    when(
      () => dataSource.fetchHomeContent(),
    ).thenThrow(const ParsingException());

    await expectLater(
      repository.getHomeContent(),
      throwsA(isA<ParsingException>()),
    );
  });

  test('wraps unexpected errors in UnknownException', () async {
    when(() => dataSource.fetchHomeContent()).thenThrow(StateError('boom'));

    await expectLater(
      repository.getHomeContent(),
      throwsA(isA<UnknownException>()),
    );
  });
}
