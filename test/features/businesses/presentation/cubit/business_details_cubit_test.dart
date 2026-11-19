import 'package:bloc_test/bloc_test.dart';
import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/core/errors/failures.dart';
import 'package:dikirnis_stor/features/businesses/presentation/cubit/business_details_cubit.dart';
import 'package:dikirnis_stor/features/businesses/presentation/cubit/business_details_state.dart';
import 'package:dikirnis_stor/features/home/domain/entities/business.dart';
import 'package:dikirnis_stor/features/home/domain/entities/home_content.dart';
import 'package:dikirnis_stor/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

const _pharmacy = Business(
  id: 'medical_1',
  name: 'صيدلية دكرنس',
  location: 'شارع الجيش، دكرنس',
  image: 'assets/images/businesses/pharmacy.jpg',
  rating: 4.6,
  views: 1200,
  description: 'صيدلية تعمل على مدار الساعة.',
  isVerified: true,
);

const _restaurant = Business(
  id: 'restaurant_1',
  name: 'مطعم النيل',
  location: 'كورنيش دكرنس',
  image: 'assets/images/businesses/nile.jpg',
  rating: 4.4,
  views: 900,
  description: 'مأكولات بحرية ومشاوي.',
);

HomeContent _content() {
  return const HomeContent(
    userName: 'أحمد محمود',
    userLocation: 'دكرنس، الدقهلية',
    banners: [],
    categories: [],
    mostViewed: [_restaurant],
    recentlyAdded: [_restaurant],
    medical: [_pharmacy],
    restaurants: [_restaurant],
  );
}

void main() {
  late MockHomeRepository repository;

  setUp(() {
    repository = MockHomeRepository();
  });

  blocTest<BusinessDetailsCubit, BusinessDetailsState>(
    'loads a business from the medical section',
    build: () {
      when(
        () => repository.getHomeContent(),
      ).thenAnswer((_) async => _content());
      return BusinessDetailsCubit(repository);
    },
    act: (cubit) => cubit.load('medical_1'),
    expect: () => [
      const BusinessDetailsState(status: BusinessDetailsStatus.loading),
      const BusinessDetailsState(
        status: BusinessDetailsStatus.success,
        business: _pharmacy,
      ),
    ],
  );

  blocTest<BusinessDetailsCubit, BusinessDetailsState>(
    'loads a business from the restaurants section',
    build: () {
      when(
        () => repository.getHomeContent(),
      ).thenAnswer((_) async => _content());
      return BusinessDetailsCubit(repository);
    },
    act: (cubit) => cubit.load('restaurant_1'),
    expect: () => [
      const BusinessDetailsState(status: BusinessDetailsStatus.loading),
      const BusinessDetailsState(
        status: BusinessDetailsStatus.success,
        business: _restaurant,
      ),
    ],
  );

  blocTest<BusinessDetailsCubit, BusinessDetailsState>(
    'emits notFound when the business does not exist',
    build: () {
      when(
        () => repository.getHomeContent(),
      ).thenAnswer((_) async => _content());
      return BusinessDetailsCubit(repository);
    },
    act: (cubit) => cubit.load('missing'),
    expect: () => [
      const BusinessDetailsState(status: BusinessDetailsStatus.loading),
      const BusinessDetailsState(status: BusinessDetailsStatus.notFound),
    ],
  );

  blocTest<BusinessDetailsCubit, BusinessDetailsState>(
    'emits failure when the repository throws',
    build: () {
      when(
        () => repository.getHomeContent(),
      ).thenThrow(const NetworkException());
      return BusinessDetailsCubit(repository);
    },
    act: (cubit) => cubit.load('medical_1'),
    expect: () => [
      const BusinessDetailsState(status: BusinessDetailsStatus.loading),
      isA<BusinessDetailsState>()
          .having(
            (state) => state.status,
            'status',
            BusinessDetailsStatus.failure,
          )
          .having(
            (state) => state.failure?.type,
            'failure type',
            FailureType.network,
          ),
    ],
  );

  blocTest<BusinessDetailsCubit, BusinessDetailsState>(
    'refresh reloads the last requested business',
    build: () {
      when(
        () => repository.getHomeContent(),
      ).thenAnswer((_) async => _content());
      return BusinessDetailsCubit(repository);
    },
    act: (cubit) async {
      await cubit.load('medical_1');
      await cubit.refresh();
    },
    expect: () => [
      const BusinessDetailsState(status: BusinessDetailsStatus.loading),
      const BusinessDetailsState(
        status: BusinessDetailsStatus.success,
        business: _pharmacy,
      ),
      const BusinessDetailsState(
        status: BusinessDetailsStatus.loading,
        business: _pharmacy,
      ),
      const BusinessDetailsState(
        status: BusinessDetailsStatus.success,
        business: _pharmacy,
      ),
    ],
    verify: (_) {
      verify(() => repository.getHomeContent()).called(2);
    },
  );
}
