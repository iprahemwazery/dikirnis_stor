import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_profile.dart';

enum ProfileStatus { initial, loading, success, failure }

const Object _unset = Object();

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.failure,
  });

  final ProfileStatus status;
  final UserProfile? profile;
  final AppFailure? failure;

  ProfileState copyWith({
    ProfileStatus? status,
    Object? profile = _unset,
    Object? failure = _unset,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: identical(profile, _unset)
          ? this.profile
          : profile as UserProfile?,
      failure: identical(failure, _unset)
          ? this.failure
          : failure as AppFailure?,
    );
  }

  @override
  List<Object?> get props => [status, profile, failure];
}
