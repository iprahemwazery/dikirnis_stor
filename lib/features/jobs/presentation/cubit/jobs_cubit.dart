import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../categories/domain/entities/service_category.dart';
import '../../domain/entities/job_candidate.dart';
import '../../domain/entities/job_enums.dart';
import '../../domain/entities/job_vacancy.dart';
import '../../domain/repositories/jobs_repository.dart';
import 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit(this._repository) : super(const JobsState());

  final JobsRepository _repository;

  Future<void> load({bool force = false}) async {
    if (state.status == JobsStatus.loading) {
      return;
    }
    if (!force &&
        (state.status == JobsStatus.success ||
            state.status == JobsStatus.empty)) {
      return;
    }

    emit(state.copyWith(status: JobsStatus.loading, failure: null));

    try {
      final catalog = await _repository.getJobsCatalog(force: force);
      if (isClosed) {
        return;
      }

      final selectedCategoryId = _validCategoryId(
        state.selectedCategoryId,
        catalog.categories,
      );
      final allVacancies = List<JobVacancy>.unmodifiable(catalog.vacancies);
      final allCandidates = List<JobCandidate>.unmodifiable(catalog.candidates);

      final filtered = _applyFilters(
        allVacancies: allVacancies,
        allCandidates: allCandidates,
        categories: catalog.categories,
        tab: state.tab,
        query: state.query,
        categoryId: selectedCategoryId,
        employmentType: state.selectedEmploymentType,
        availability: state.selectedAvailability,
        sort: state.sort,
      );

      emit(
        state.copyWith(
          status: catalog.isEmpty ? JobsStatus.empty : JobsStatus.success,
          categories: List<ServiceCategory>.unmodifiable(catalog.categories),
          allVacancies: allVacancies,
          allCandidates: allCandidates,
          vacancies: filtered.vacancies,
          candidates: filtered.candidates,
          selectedCategoryId: selectedCategoryId,
          failure: null,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (error) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          status: JobsStatus.failure,
          failure: AppFailure.fromException(error),
        ),
      );
    }
  }

  Future<void> refresh() => load(force: true);

  void selectTab(JobsTab tab) {
    if (tab == state.tab) {
      return;
    }
    emit(state.copyWith(tab: tab));
  }

  void search(String rawQuery) {
    final query = rawQuery.trim();
    if (query == state.query) {
      return;
    }
    _emitFiltered(state.copyWith(query: query));
  }

  void selectCategory(String? categoryId) {
    if (categoryId == state.selectedCategoryId) {
      return;
    }
    _emitFiltered(state.copyWith(selectedCategoryId: categoryId));
  }

  void selectEmploymentType(EmploymentType? employmentType) {
    if (employmentType == state.selectedEmploymentType) {
      return;
    }
    _emitFiltered(state.copyWith(selectedEmploymentType: employmentType));
  }

  void selectAvailability(CandidateAvailability? availability) {
    if (availability == state.selectedAvailability) {
      return;
    }
    _emitFiltered(state.copyWith(selectedAvailability: availability));
  }

  void selectSort(JobsSort sort) {
    if (sort == state.sort) {
      return;
    }
    _emitFiltered(state.copyWith(sort: sort));
  }

  void clearFilters() {
    if (!state.hasActiveFilters &&
        state.selectedEmploymentType == null &&
        state.selectedAvailability == null &&
        state.sort == JobsSort.newest) {
      return;
    }
    _emitFiltered(
      state.copyWith(
        selectedCategoryId: null,
        selectedEmploymentType: null,
        selectedAvailability: null,
        sort: JobsSort.newest,
      ),
    );
  }

  void _emitFiltered(JobsState next) {
    if (state.status != JobsStatus.success &&
        state.status != JobsStatus.empty) {
      emit(next);
      return;
    }
    final filtered = _applyFilters(
      allVacancies: state.allVacancies,
      allCandidates: state.allCandidates,
      categories: state.categories,
      tab: next.tab,
      query: next.query,
      categoryId: next.selectedCategoryId,
      employmentType: next.selectedEmploymentType,
      availability: next.selectedAvailability,
      sort: next.sort,
    );
    emit(
      next.copyWith(
        vacancies: filtered.vacancies,
        candidates: filtered.candidates,
      ),
    );
  }

  _FilteredJobs _applyFilters({
    required List<JobVacancy> allVacancies,
    required List<JobCandidate> allCandidates,
    required List<ServiceCategory> categories,
    required JobsTab tab,
    required String query,
    required String? categoryId,
    required EmploymentType? employmentType,
    required CandidateAvailability? availability,
    required JobsSort sort,
  }) {
    final normalizedQuery = query.toLowerCase();
    final categoryNames = {
      for (final category in categories)
        category.id: '${category.nameAr} ${category.nameEn}'.toLowerCase(),
    };

    final vacancies = allVacancies.where((vacancy) {
      if (categoryId != null && vacancy.categoryId != categoryId) {
        return false;
      }
      if (employmentType != null && vacancy.employmentType != employmentType) {
        return false;
      }
      if (normalizedQuery.isEmpty) {
        return true;
      }
      final categoryName = categoryNames[vacancy.categoryId] ?? '';
      return vacancy.title.toLowerCase().contains(normalizedQuery) ||
          vacancy.companyName.toLowerCase().contains(normalizedQuery) ||
          vacancy.location.toLowerCase().contains(normalizedQuery) ||
          vacancy.shortDescription.toLowerCase().contains(normalizedQuery) ||
          vacancy.description.toLowerCase().contains(normalizedQuery) ||
          categoryName.contains(normalizedQuery);
    }).toList();

    final candidates = allCandidates.where((candidate) {
      if (categoryId != null && candidate.categoryId != categoryId) {
        return false;
      }
      if (availability != null && candidate.availability != availability) {
        return false;
      }
      if (normalizedQuery.isEmpty) {
        return true;
      }
      final categoryName = categoryNames[candidate.categoryId] ?? '';
      return candidate.fullName.toLowerCase().contains(normalizedQuery) ||
          candidate.professionalTitle.toLowerCase().contains(normalizedQuery) ||
          candidate.preferredLocation.toLowerCase().contains(normalizedQuery) ||
          candidate.summary.toLowerCase().contains(normalizedQuery) ||
          candidate.skills.any(
            (skill) => skill.toLowerCase().contains(normalizedQuery),
          ) ||
          categoryName.contains(normalizedQuery);
    }).toList();

    _sortVacancies(vacancies, sort);
    _sortCandidates(candidates, sort);

    return _FilteredJobs(
      vacancies: List<JobVacancy>.unmodifiable(vacancies),
      candidates: List<JobCandidate>.unmodifiable(candidates),
    );
  }

  void _sortVacancies(List<JobVacancy> vacancies, JobsSort sort) {
    switch (sort) {
      case JobsSort.salaryHighLow:
        vacancies.sort((a, b) {
          final aSalary = a.salaryMax ?? a.salaryMin ?? 0;
          final bSalary = b.salaryMax ?? b.salaryMin ?? 0;
          return bSalary.compareTo(aSalary);
        });
        return;
      case JobsSort.salaryLowHigh:
        vacancies.sort((a, b) {
          final aSalary = a.salaryMin ?? a.salaryMax ?? 0;
          final bSalary = b.salaryMin ?? b.salaryMax ?? 0;
          return aSalary.compareTo(bSalary);
        });
        return;
      case JobsSort.experienceHigh:
      case JobsSort.newest:
        vacancies.sort(
          (a, b) => a.publishedDaysAgo.compareTo(b.publishedDaysAgo),
        );
        return;
    }
  }

  void _sortCandidates(List<JobCandidate> candidates, JobsSort sort) {
    switch (sort) {
      case JobsSort.experienceHigh:
        candidates.sort(
          (a, b) => b.experienceYears.compareTo(a.experienceYears),
        );
        return;
      case JobsSort.newest:
      case JobsSort.salaryHighLow:
      case JobsSort.salaryLowHigh:
        candidates.sort(
          (a, b) => a.publishedDaysAgo.compareTo(b.publishedDaysAgo),
        );
        return;
    }
  }

  String? _validCategoryId(
    String? categoryId,
    List<ServiceCategory> categories,
  ) {
    if (categoryId == null) {
      return null;
    }
    return categories.any((category) => category.id == categoryId)
        ? categoryId
        : null;
  }
}

class _FilteredJobs {
  const _FilteredJobs({required this.vacancies, required this.candidates});

  final List<JobVacancy> vacancies;
  final List<JobCandidate> candidates;
}
