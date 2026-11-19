import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../categories/domain/entities/service_category.dart';
import '../../domain/entities/job_candidate.dart';
import '../../domain/entities/job_enums.dart';
import '../../domain/entities/job_vacancy.dart';

enum JobsTab { vacancies, candidates }

enum JobsStatus { initial, loading, success, empty, failure }

enum JobsSort { newest, salaryHighLow, salaryLowHigh, experienceHigh }

const Object _unset = Object();

class JobsState extends Equatable {
  const JobsState({
    this.status = JobsStatus.initial,
    this.tab = JobsTab.vacancies,
    this.query = '',
    this.categories = const [],
    this.allVacancies = const [],
    this.allCandidates = const [],
    this.vacancies = const [],
    this.candidates = const [],
    this.selectedCategoryId,
    this.selectedEmploymentType,
    this.selectedAvailability,
    this.sort = JobsSort.newest,
    this.failure,
  });

  final JobsStatus status;
  final JobsTab tab;
  final String query;
  final List<ServiceCategory> categories;
  final List<JobVacancy> allVacancies;
  final List<JobCandidate> allCandidates;
  final List<JobVacancy> vacancies;
  final List<JobCandidate> candidates;
  final String? selectedCategoryId;
  final EmploymentType? selectedEmploymentType;
  final CandidateAvailability? selectedAvailability;
  final JobsSort sort;
  final AppFailure? failure;

  bool get isSearching => query.isNotEmpty;

  bool get hasActiveFilters =>
      selectedCategoryId != null ||
      selectedEmploymentType != null ||
      selectedAvailability != null;

  int get resultCount =>
      tab == JobsTab.vacancies ? vacancies.length : candidates.length;

  bool get isTabEmpty =>
      tab == JobsTab.vacancies ? vacancies.isEmpty : candidates.isEmpty;

  String? categoryName(String categoryId, String languageCode) {
    for (final category in categories) {
      if (category.id == categoryId) {
        return category.localizedName(languageCode);
      }
    }
    return null;
  }

  JobsState copyWith({
    JobsStatus? status,
    JobsTab? tab,
    String? query,
    List<ServiceCategory>? categories,
    List<JobVacancy>? allVacancies,
    List<JobCandidate>? allCandidates,
    List<JobVacancy>? vacancies,
    List<JobCandidate>? candidates,
    Object? selectedCategoryId = _unset,
    Object? selectedEmploymentType = _unset,
    Object? selectedAvailability = _unset,
    JobsSort? sort,
    Object? failure = _unset,
  }) {
    return JobsState(
      status: status ?? this.status,
      tab: tab ?? this.tab,
      query: query ?? this.query,
      categories: categories ?? this.categories,
      allVacancies: allVacancies ?? this.allVacancies,
      allCandidates: allCandidates ?? this.allCandidates,
      vacancies: vacancies ?? this.vacancies,
      candidates: candidates ?? this.candidates,
      selectedCategoryId: identical(selectedCategoryId, _unset)
          ? this.selectedCategoryId
          : selectedCategoryId as String?,
      selectedEmploymentType: identical(selectedEmploymentType, _unset)
          ? this.selectedEmploymentType
          : selectedEmploymentType as EmploymentType?,
      selectedAvailability: identical(selectedAvailability, _unset)
          ? this.selectedAvailability
          : selectedAvailability as CandidateAvailability?,
      sort: sort ?? this.sort,
      failure: identical(failure, _unset)
          ? this.failure
          : failure as AppFailure?,
    );
  }

  @override
  List<Object?> get props => [
    status,
    tab,
    query,
    categories,
    allVacancies,
    allCandidates,
    vacancies,
    candidates,
    selectedCategoryId,
    selectedEmploymentType,
    selectedAvailability,
    sort,
    failure,
  ];
}
