import 'package:equatable/equatable.dart';

import '../../../categories/domain/entities/service_category.dart';
import 'job_candidate.dart';
import 'job_vacancy.dart';

class JobsCatalog extends Equatable {
  const JobsCatalog({
    this.vacancies = const [],
    this.candidates = const [],
    this.categories = const [],
  });

  final List<JobVacancy> vacancies;
  final List<JobCandidate> candidates;
  final List<ServiceCategory> categories;

  bool get isEmpty => vacancies.isEmpty && candidates.isEmpty;

  @override
  List<Object?> get props => [vacancies, candidates, categories];
}
