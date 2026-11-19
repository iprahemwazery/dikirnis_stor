import '../../../categories/domain/entities/service_category.dart';
import '../../domain/entities/jobs_catalog.dart';
import 'job_candidate_model.dart';
import 'job_vacancy_model.dart';

class JobsCatalogModel {
  const JobsCatalogModel({
    this.categories = const [],
    this.vacancies = const [],
    this.candidates = const [],
  });

  factory JobsCatalogModel.fromJson(Map<String, dynamic> json) {
    return JobsCatalogModel(
      categories: _categoryList(json['categories']),
      vacancies: _vacancyList(json['vacancies']),
      candidates: _candidateList(json['candidates']),
    );
  }

  final List<ServiceCategory> categories;
  final List<JobVacancyModel> vacancies;
  final List<JobCandidateModel> candidates;

  JobsCatalog toEntity() {
    return JobsCatalog(
      categories: List<ServiceCategory>.unmodifiable(categories),
      vacancies: List.unmodifiable(
        vacancies.map((vacancy) => vacancy.toEntity()),
      ),
      candidates: List.unmodifiable(
        candidates.map((candidate) => candidate.toEntity()),
      ),
    );
  }
}

List<ServiceCategory> _categoryList(Object? value) {
  if (value is! List) {
    return const [];
  }
  return value
      .whereType<Map<String, dynamic>>()
      .map((json) {
        return ServiceCategory(
          id: json['id'] as String,
          nameAr: json['name_ar'] as String? ?? '',
          nameEn: json['name_en'] as String? ?? '',
          iconKey: json['icon_key'] as String? ?? 'work',
          providersCount: (json['providers_count'] as num?)?.toInt() ?? 0,
          subcategoriesCount:
              (json['subcategories_count'] as num?)?.toInt() ?? 0,
        );
      })
      .toList(growable: false);
}

List<JobVacancyModel> _vacancyList(Object? value) {
  if (value is! List) {
    return const [];
  }
  return value
      .whereType<Map<String, dynamic>>()
      .map(JobVacancyModel.fromJson)
      .toList(growable: false);
}

List<JobCandidateModel> _candidateList(Object? value) {
  if (value is! List) {
    return const [];
  }
  return value
      .whereType<Map<String, dynamic>>()
      .map(JobCandidateModel.fromJson)
      .toList(growable: false);
}
