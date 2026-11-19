import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/job_candidate.dart';
import '../../domain/entities/job_vacancy.dart';
import '../../domain/entities/jobs_catalog.dart';
import '../../domain/repositories/jobs_repository.dart';
import '../datasources/jobs_data_source.dart';

class JobsRepositoryImpl implements JobsRepository {
  JobsRepositoryImpl(
    this._dataSource, {
    this.cacheTtl = const Duration(minutes: 2),
  });

  final JobsDataSource _dataSource;
  final Duration cacheTtl;

  JobsCatalog? _cachedCatalog;
  DateTime? _cachedAt;
  Future<JobsCatalog>? _pendingRequest;

  @override
  Future<JobsCatalog> getJobsCatalog({bool force = false}) {
    if (!force && _hasFreshCache) {
      return Future.value(_cachedCatalog);
    }

    final pendingRequest = _pendingRequest;
    if (!force && pendingRequest != null) {
      return pendingRequest;
    }

    final request = _loadCatalog();
    late final Future<JobsCatalog> trackedRequest;
    trackedRequest = request.whenComplete(() {
      if (identical(_pendingRequest, trackedRequest)) {
        _pendingRequest = null;
      }
    });
    _pendingRequest = trackedRequest;
    return trackedRequest;
  }

  bool get _hasFreshCache {
    final cachedAt = _cachedAt;
    if (_cachedCatalog == null || cachedAt == null) {
      return false;
    }
    return DateTime.now().difference(cachedAt) < cacheTtl;
  }

  Future<JobsCatalog> _loadCatalog() async {
    try {
      final model = await _dataSource.fetchJobsCatalog();
      final catalog = model.toEntity();
      _cachedCatalog = catalog;
      _cachedAt = DateTime.now();
      return catalog;
    } on AppException catch (error) {
      if (_cachedCatalog != null &&
          (error is NetworkException ||
              error is RequestTimeoutException ||
              error is ServerException)) {
        return _cachedCatalog!;
      }
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UnknownException(cause: error), stackTrace);
    }
  }

  @override
  Future<JobVacancy> getVacancyById(String vacancyId) async {
    final catalog = await getJobsCatalog();
    for (final vacancy in catalog.vacancies) {
      if (vacancy.id == vacancyId) {
        return vacancy;
      }
    }
    throw const NotFoundException(
      message: 'The requested job vacancy was not found.',
    );
  }

  @override
  Future<JobCandidate> getCandidateById(String candidateId) async {
    final catalog = await getJobsCatalog();
    for (final candidate in catalog.candidates) {
      if (candidate.id == candidateId) {
        return candidate;
      }
    }
    throw const NotFoundException(
      message: 'The requested candidate was not found.',
    );
  }
}
