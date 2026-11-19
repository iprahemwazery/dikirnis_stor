import '../entities/job_candidate.dart';
import '../entities/job_vacancy.dart';
import '../entities/jobs_catalog.dart';

abstract interface class JobsRepository {
  Future<JobsCatalog> getJobsCatalog({bool force = false});

  Future<JobVacancy> getVacancyById(String vacancyId);

  Future<JobCandidate> getCandidateById(String candidateId);
}
