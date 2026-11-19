import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/features/categories/domain/entities/service_category.dart';
import 'package:dikirnis_stor/features/jobs/data/datasources/jobs_data_source.dart';
import 'package:dikirnis_stor/features/jobs/data/models/job_candidate_model.dart';
import 'package:dikirnis_stor/features/jobs/data/models/job_vacancy_model.dart';
import 'package:dikirnis_stor/features/jobs/data/models/jobs_catalog_model.dart';
import 'package:dikirnis_stor/features/jobs/data/repositories/jobs_repository_impl.dart';
import 'package:dikirnis_stor/features/jobs/domain/entities/job_enums.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockJobsDataSource extends Mock implements JobsDataSource {}

final _model = JobsCatalogModel(
  categories: const [
    ServiceCategory(
      id: 'technology',
      nameAr: 'تقنية المعلومات',
      nameEn: 'Information technology',
      iconKey: 'technology',
      providersCount: 3,
    ),
  ],
  vacancies: const [
    JobVacancyModel(
      id: 'vacancy_flutter',
      title: 'مطور Flutter',
      companyName: 'مركز تكنو',
      categoryId: 'technology',
      employmentType: EmploymentType.fullTime,
      location: 'دكرنس',
      publishedDaysAgo: 1,
      shortDescription: 'تطوير تطبيقات',
      description: 'تطوير تطبيقات Flutter.',
      salaryMin: 8000,
      salaryMax: 12000,
      salaryPeriod: SalaryPeriod.monthly,
      contactPhone: '+201000000000',
      isVerified: true,
    ),
  ],
  candidates: const [
    JobCandidateModel(
      id: 'candidate_ahmed',
      fullName: 'أحمد محمود',
      professionalTitle: 'مطور Flutter',
      categoryId: 'technology',
      experienceYears: 4,
      preferredLocation: 'دكرنس',
      desiredEmploymentType: EmploymentType.fullTime,
      summary: 'مطور تطبيقات.',
      availability: CandidateAvailability.availableNow,
      publishedDaysAgo: 2,
      skills: ['Flutter', 'Dart'],
      contactEmail: 'ahmed@example.com',
    ),
  ],
);

void main() {
  late MockJobsDataSource dataSource;
  late JobsRepositoryImpl repository;

  setUp(() {
    dataSource = MockJobsDataSource();
    repository = JobsRepositoryImpl(dataSource);
  });

  test('maps the data-source model to a domain catalog', () async {
    when(() => dataSource.fetchJobsCatalog()).thenAnswer((_) async => _model);

    final catalog = await repository.getJobsCatalog();

    expect(catalog.categories, hasLength(1));
    expect(catalog.vacancies, hasLength(1));
    expect(catalog.candidates, hasLength(1));
    expect(catalog.vacancies.first.title, 'مطور Flutter');
    expect(catalog.vacancies.first.salaryPeriod, SalaryPeriod.monthly);
    expect(catalog.candidates.first.skills, ['Flutter', 'Dart']);
  });

  test('caches the catalog for repeated loads', () async {
    when(() => dataSource.fetchJobsCatalog()).thenAnswer((_) async => _model);

    await repository.getJobsCatalog();
    await repository.getJobsCatalog();

    verify(() => dataSource.fetchJobsCatalog()).called(1);
  });

  test('force reload bypasses the cache', () async {
    when(() => dataSource.fetchJobsCatalog()).thenAnswer((_) async => _model);

    await repository.getJobsCatalog();
    await repository.getJobsCatalog(force: true);

    verify(() => dataSource.fetchJobsCatalog()).called(2);
  });

  test('returns the cached catalog when a network error occurs', () async {
    repository = JobsRepositoryImpl(dataSource, cacheTtl: Duration.zero);
    when(() => dataSource.fetchJobsCatalog()).thenAnswer((_) async => _model);

    final first = await repository.getJobsCatalog();

    when(() => dataSource.fetchJobsCatalog()).thenThrow(NetworkException());

    final second = await repository.getJobsCatalog();

    expect(identical(first, second), isTrue);
  });

  test('does not serve a stale cache after a parsing error', () async {
    repository = JobsRepositoryImpl(dataSource, cacheTtl: Duration.zero);
    when(() => dataSource.fetchJobsCatalog()).thenAnswer((_) async => _model);

    await repository.getJobsCatalog();

    when(
      () => dataSource.fetchJobsCatalog(),
    ).thenThrow(const ParsingException());

    await expectLater(
      repository.getJobsCatalog(),
      throwsA(isA<ParsingException>()),
    );
  });

  test('finds a vacancy by id and throws when missing', () async {
    when(() => dataSource.fetchJobsCatalog()).thenAnswer((_) async => _model);

    final vacancy = await repository.getVacancyById('vacancy_flutter');
    expect(vacancy.title, 'مطور Flutter');

    await expectLater(
      repository.getVacancyById('missing'),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('finds a candidate by id and throws when missing', () async {
    when(() => dataSource.fetchJobsCatalog()).thenAnswer((_) async => _model);

    final candidate = await repository.getCandidateById('candidate_ahmed');
    expect(candidate.fullName, 'أحمد محمود');

    await expectLater(
      repository.getCandidateById('missing'),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('wraps unexpected errors in UnknownException', () async {
    when(() => dataSource.fetchJobsCatalog()).thenThrow(StateError('boom'));

    await expectLater(
      repository.getJobsCatalog(),
      throwsA(isA<UnknownException>()),
    );
  });
}
