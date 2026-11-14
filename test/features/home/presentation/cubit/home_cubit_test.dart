import 'package:bloc_test/bloc_test.dart';
import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/core/errors/failures.dart';
import 'package:dikirnis_stor/features/home/domain/entities/business.dart';
import 'package:dikirnis_stor/features/home/domain/entities/home_advertisement.dart';
import 'package:dikirnis_stor/features/home/domain/entities/home_banner.dart';
import 'package:dikirnis_stor/features/home/domain/entities/home_category.dart';
import 'package:dikirnis_stor/features/home/domain/entities/home_content.dart';
import 'package:dikirnis_stor/features/home/domain/repositories/home_repository.dart';
import 'package:dikirnis_stor/features/home/presentation/cubit/home_cubit.dart';
import 'package:dikirnis_stor/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

const _business = Business(
  id: 'business_1',
  name: 'أسماك النيل',
  location: 'شارع الجيش، دكرنس',
  image: 'assets/images/businesses/fish_house.jpg',
  rating: 4.8,
  views: 1840,
  rank: 1,
);

const _advertisement = HomeAdvertisement(
  id: 'crocodile',
  advertiserName: 'Crocodile',
  description: 'خصومات على مستلزمات المنزل.',
  logoIconKey: 'storefront',
);

HomeContent _content({bool empty = false, bool withAdvertisement = true}) {
  return HomeContent(
    userName: 'أحمد محمود',
    userLocation: 'دكرنس، الدقهلية',
    banners: empty
        ? const []
        : const [
            HomeBanner(
              id: 'banner_1',
              title: 'مذاق دكرنس',
              subtitle: 'أفضل المطاعم',
              image: 'assets/images/banners/banner_restaurants.jpg',
            ),
          ],
    categories: empty
        ? const []
        : const [
            HomeCategory(
              id: 'restaurants_cafes',
              name: 'مطاعم وكافيهات',
              iconKey: 'restaurant',
            ),
          ],
    mostViewed: empty ? const [] : const [_business],
    recentlyAdded: empty ? const [] : const [_business],
    medical: empty ? const [] : const [_business],
    restaurants: empty ? const [] : const [_business],
    advertisement: empty || !withAdvertisement ? null : _advertisement,
  );
}

void main() {
  late MockHomeRepository repository;

  setUp(() {
    repository = MockHomeRepository();
  });

  blocTest<HomeCubit, HomeState>(
    'emits loading then success when content loads',
    build: () {
      when(
        () => repository.getHomeContent(),
      ).thenAnswer((_) async => _content());
      return HomeCubit(repository);
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const HomeState(status: HomeStatus.loading),
      HomeState(status: HomeStatus.success, content: _content()),
    ],
    verify: (_) {
      verify(() => repository.getHomeContent()).called(1);
    },
  );

  blocTest<HomeCubit, HomeState>(
    'emits empty when the preview contains no sections',
    build: () {
      when(
        () => repository.getHomeContent(),
      ).thenAnswer((_) async => _content(empty: true));
      return HomeCubit(repository);
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const HomeState(status: HomeStatus.loading),
      HomeState(status: HomeStatus.empty, content: _content(empty: true)),
    ],
  );

  test('emits a mapped failure when loading throws', () async {
    when(() => repository.getHomeContent()).thenThrow(const NetworkException());

    final cubit = HomeCubit(repository);
    final states = <HomeState>[];
    final subscription = cubit.stream.listen(states.add);

    await cubit.load();
    await Future<void>.delayed(Duration.zero);

    expect(states.map((state) => state.status), [
      HomeStatus.loading,
      HomeStatus.failure,
    ]);
    expect(states.last.failure?.type, FailureType.network);
    expect(states.last.content, isNull);

    await subscription.cancel();
    await cubit.close();
  });

  blocTest<HomeCubit, HomeState>(
    'does not reload after a successful load',
    build: () {
      when(
        () => repository.getHomeContent(),
      ).thenAnswer((_) async => _content());
      return HomeCubit(repository);
    },
    act: (cubit) async {
      await cubit.load();
      await cubit.load();
    },
    expect: () => [
      const HomeState(status: HomeStatus.loading),
      HomeState(status: HomeStatus.success, content: _content()),
    ],
    verify: (_) {
      verify(() => repository.getHomeContent()).called(1);
    },
  );

  blocTest<HomeCubit, HomeState>(
    'refresh forces a second load',
    build: () {
      when(
        () => repository.getHomeContent(),
      ).thenAnswer((_) async => _content());
      return HomeCubit(repository);
    },
    act: (cubit) async {
      await cubit.load();
      await cubit.refresh();
    },
    expect: () => [
      const HomeState(status: HomeStatus.loading),
      HomeState(status: HomeStatus.success, content: _content()),
      HomeState(status: HomeStatus.loading, content: _content()),
      HomeState(status: HomeStatus.success, content: _content()),
    ],
    verify: (_) {
      verify(() => repository.getHomeContent()).called(2);
    },
  );

  test('normalizes and stores the submitted search query', () async {
    final cubit = HomeCubit(repository);

    cubit.submitSearch('  مطعم  ');
    expect(cubit.state.searchQuery, 'مطعم');

    cubit.submitSearch('مطعم');
    expect(cubit.state.searchQuery, 'مطعم');

    cubit.submitSearch('   ');
    expect(cubit.state.searchQuery, isEmpty);

    await cubit.close();
  });

  test('dismisses the advertisement and ignores repeated dismissal', () async {
    when(() => repository.getHomeContent()).thenAnswer((_) async => _content());

    final cubit = HomeCubit(repository);
    await cubit.load();

    expect(cubit.state.advertisement, isNotNull);

    cubit.dismissAdvertisement();
    expect(cubit.state.advertisementDismissed, isTrue);
    expect(cubit.state.advertisement, isNull);

    cubit.dismissAdvertisement();
    expect(cubit.state.advertisementDismissed, isTrue);

    await cubit.close();
  });

  test('keeps the advertisement dismissed after a refresh', () async {
    when(() => repository.getHomeContent()).thenAnswer((_) async => _content());

    final cubit = HomeCubit(repository);
    await cubit.load();
    cubit.dismissAdvertisement();

    await cubit.refresh();

    expect(cubit.state.status, HomeStatus.success);
    expect(cubit.state.advertisementDismissed, isTrue);
    expect(cubit.state.advertisement, isNull);

    await cubit.close();
  });
}
