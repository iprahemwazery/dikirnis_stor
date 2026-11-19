import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../categories/domain/entities/service_category.dart';
import '../../domain/entities/job_candidate.dart';
import '../../domain/entities/job_vacancy.dart';

enum JobDetailsKind { vacancy, candidate }

enum JobDetailsStatus { initial, loading, success, failure }

const Object _unset = Object();

class JobDetailsState extends Equatable {
  const JobDetailsState({
    this.status = JobDetailsStatus.initial,
    this.kind,
    this.vacancy,
    this.candidate,
    this.category,
    this.failure,
  });

  final JobDetailsStatus status;
  final JobDetailsKind? kind;
  final JobVacancy? vacancy;
  final JobCandidate? candidate;
  final ServiceCategory? category;
  final AppFailure? failure;

  bool get isVacancy => kind == JobDetailsKind.vacancy;

  JobDetailsState copyWith({
    JobDetailsStatus? status,
    Object? kind = _unset,
    Object? vacancy = _unset,
    Object? candidate = _unset,
    Object? failure = _unset,
  }) {
    return JobDetailsState(
      status: status ?? this.status,
      kind: identical(kind, _unset) ? this.kind : kind as JobDetailsKind?,
      vacancy: identical(vacancy, _unset)
          ? this.vacancy
          : vacancy as JobVacancy?,
      candidate: identical(candidate, _unset)
          ? this.candidate
          : candidate as JobCandidate?,
      failure: identical(failure, _unset)
          ? this.failure
          : failure as AppFailure?,
    );
  }

  @override
  List<Object?> get props => [
    status,
    kind,
    vacancy,
    candidate,
    category,
    failure,
  ];
}
