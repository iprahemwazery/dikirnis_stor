import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repository) : super(const ProfileState());

  final ProfileRepository _repository;

  Future<void> load({bool force = false}) async {
    if (state.status == ProfileStatus.loading) {
      return;
    }
    if (!force && state.status == ProfileStatus.success) {
      return;
    }

    emit(state.copyWith(status: ProfileStatus.loading, failure: null));

    try {
      final profile = await _repository.getProfile();
      if (isClosed) {
        return;
      }

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profile,
          failure: null,
        ),
      );
    } catch (error) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          failure: AppFailure.fromException(error),
        ),
      );
    }
  }

  Future<void> refresh() => load(force: true);
}
