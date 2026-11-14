import 'package:bloc_test/bloc_test.dart';
import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/core/errors/failures.dart';
import 'package:dikirnis_stor/features/profile/domain/entities/user_profile.dart';
import 'package:dikirnis_stor/features/profile/domain/repositories/profile_repository.dart';
import 'package:dikirnis_stor/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:dikirnis_stor/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

const _profile = UserProfile(
  name: 'أحمد محمود',
  location: 'دكرنس، الدقهلية',
  memberSince: '2024',
  ordersCount: 12,
  favoritesCount: 8,
  reviewsCount: 5,
);

void main() {
  late MockProfileRepository repository;

  setUp(() {
    repository = MockProfileRepository();
  });

  blocTest<ProfileCubit, ProfileState>(
    'emits loading then success when the profile loads',
    build: () {
      when(() => repository.getProfile()).thenAnswer((_) async => _profile);
      return ProfileCubit(repository);
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const ProfileState(status: ProfileStatus.loading),
      const ProfileState(status: ProfileStatus.success, profile: _profile),
    ],
    verify: (_) {
      verify(() => repository.getProfile()).called(1);
    },
  );

  test('emits a mapped failure when loading throws', () async {
    when(() => repository.getProfile()).thenThrow(const NetworkException());

    final cubit = ProfileCubit(repository);
    final states = <ProfileState>[];
    final subscription = cubit.stream.listen(states.add);

    await cubit.load();
    await Future<void>.delayed(Duration.zero);

    expect(states.map((state) => state.status), [
      ProfileStatus.loading,
      ProfileStatus.failure,
    ]);
    expect(states.last.failure?.type, FailureType.network);
    expect(states.last.profile, isNull);

    await subscription.cancel();
    await cubit.close();
  });

  blocTest<ProfileCubit, ProfileState>(
    'does not reload after a successful load',
    build: () {
      when(() => repository.getProfile()).thenAnswer((_) async => _profile);
      return ProfileCubit(repository);
    },
    act: (cubit) async {
      await cubit.load();
      await cubit.load();
    },
    expect: () => [
      const ProfileState(status: ProfileStatus.loading),
      const ProfileState(status: ProfileStatus.success, profile: _profile),
    ],
    verify: (_) {
      verify(() => repository.getProfile()).called(1);
    },
  );

  blocTest<ProfileCubit, ProfileState>(
    'refresh forces a second load',
    build: () {
      when(() => repository.getProfile()).thenAnswer((_) async => _profile);
      return ProfileCubit(repository);
    },
    act: (cubit) async {
      await cubit.load();
      await cubit.refresh();
    },
    expect: () => [
      const ProfileState(status: ProfileStatus.loading),
      const ProfileState(status: ProfileStatus.success, profile: _profile),
      const ProfileState(status: ProfileStatus.loading, profile: _profile),
      const ProfileState(status: ProfileStatus.success, profile: _profile),
    ],
    verify: (_) {
      verify(() => repository.getProfile()).called(2);
    },
  );
}
