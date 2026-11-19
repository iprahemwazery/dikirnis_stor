import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../categories/domain/entities/service_category.dart';
import '../../domain/entities/job_candidate.dart';
import '../../domain/entities/job_vacancy.dart';
import '../../domain/entities/jobs_catalog.dart';
import '../../domain/repositories/jobs_repository.dart';
import 'job_details_state.dart';

class JobDetailsCubit extends Cubit<JobDetailsState> {
  JobDetailsCubit(this._repository) : super(const JobDetailsState());

  final JobsRepository _repository;

  JobDetailsKind? _lastKind;
  String? _lastId;
  int _requestGeneration = 0;

  Future<void> loadVacancy(String vacancyId) {
    _lastKind = JobDetailsKind.vacancy;
    _lastId = vacancyId;
    return _load(kind: JobDetailsKind.vacancy, id: vacancyId);
  }

  Future<void> loadCandidate(String candidateId) {
    _lastKind = JobDetailsKind.candidate;
    _lastId = candidateId;
    return _load(kind: JobDetailsKind.candidate, id: candidateId);
  }

  Future<void> refresh() async {
    final kind = _lastKind;
    final id = _lastId;
    if (kind == null || id == null) {
      return;
    }
    if (kind == JobDetailsKind.vacancy) {
      await loadVacancy(id);
    } else {
      await loadCandidate(id);
    }
  }

  Future<void> _load({required JobDetailsKind kind, required String id}) async {
    final generation = ++_requestGeneration;

    emit(JobDetailsState(status: JobDetailsStatus.loading, kind: kind));

    try {
      if (kind == JobDetailsKind.vacancy) {
        final JobVacancy vacancy = await _repository.getVacancyById(id);
        final JobsCatalog catalog = await _repository.getJobsCatalog();
        if (isClosed || generation != _requestGeneration) {
          return;
        }
        emit(
          JobDetailsState(
            status: JobDetailsStatus.success,
            kind: JobDetailsKind.vacancy,
            vacancy: vacancy,
            category: _findCategory(catalog.categories, vacancy.categoryId),
          ),
        );
        return;
      }

      final JobCandidate candidate = await _repository.getCandidateById(id);
      final JobsCatalog catalog = await _repository.getJobsCatalog();
      if (isClosed || generation != _requestGeneration) {
        return;
      }
      emit(
        JobDetailsState(
          status: JobDetailsStatus.success,
          kind: JobDetailsKind.candidate,
          candidate: candidate,
          category: _findCategory(catalog.categories, candidate.categoryId),
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (error) {
      if (isClosed || generation != _requestGeneration) {
        return;
      }
      emit(
        JobDetailsState(
          status: JobDetailsStatus.failure,
          kind: kind,
          failure: AppFailure.fromException(error),
        ),
      );
    }
  }

  ServiceCategory? _findCategory(
    List<ServiceCategory> categories,
    String categoryId,
  ) {
    for (final category in categories) {
      if (category.id == categoryId) {
        return category;
      }
    }
    return null;
  }
}
