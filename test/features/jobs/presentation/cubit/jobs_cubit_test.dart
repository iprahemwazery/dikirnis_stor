import 'package:bloc_test/bloc_test.dart';
import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/core/errors/failures.dart';
import 'package:dikirnis_stor/features/categories/domain/entities/service_category.dart';
import 'package:dikirnis_stor/features/jobs/domain/entities/job_candidate.dart';
import 'package:dikirnis_stor/features/jobs/domain/entities/job_enums.dart';
import 'package:dikirnis_stor/features/jobs/domain/entities/job_vacancy.dart';
import 'package:dikirnis_stor/features/jobs/domain/entities/jobs_catalog.dart';
import 'package:dikirnis_stor/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:dikirnis_stor/features/jobs/presentation/cubit/jobs_cubit.dart';
import 'package:dikirnis_stor/features/jobs/presentation/cubit/jobs_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockJobsRepository extends Mock implements JobsRepository {}

const _categories = [
  ServiceCategory(
    id: 'technology',
    nameAr: 'تقنية المعلومات',
    nameEn: 'Information technology',
    iconKey: 'technology',
    providersCount: 0,
  ),
  ServiceCategory(
    id: 'finance',
    nameAr: 'المحاسبة والمالية',
    nameEn: 'Accounting & finance',
    iconKey: 'finance',
    providersCount: 0,
  ),
];

const _vacancies = [
  JobVacancy(
    id: 'vacancy_flutter',
    title: 'مطور Flutter',
    companyName: 'مركز تكنو',
    categoryId: 'technology',
    employmentType: EmploymentType.fullTime,
    location: 'دكرنس',
    publishedDaysAgo: 2,
    shortDescription: 'تطوير تطبيقات',
    description: 'تطوير تطبيقات Flutter.',
    salaryMin: 8000,
    salaryMax: 12000,
    salaryPeriod: SalaryPeriod.monthly,
  ),
  JobVacancy(
    id: 'vacancy_accountant',
    title: 'محاسب',
    companyName: 'سوبرماركت الأمانة',
    categoryId: 'finance',
    employmentType: EmploymentType.fullTime,
    location: 'دكرنس',
    publishedDaysAgo: 1,
    shortDescription: 'إدارة الحسابات',
    description: 'إعداد التقارير المالية.',
    salaryMin: 5000,
    salaryPeriod: SalaryPeriod.monthly,
  ),
  JobVacancy(
    id: 'vacancy_designer',
    title: 'مصمم جرافيك',
    companyName: 'استوديو الإبداع',
    categoryId: 'technology',
    employmentType: EmploymentType.partTime,
    location: 'المنصورة',
    publishedDaysAgo: 3,
    shortDescription: 'تصميم هوية بصرية',
    description: 'تصميم مواد تسويقية.',
  ),
];

const _candidates = [
  JobCandidate(
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
  ),
  JobCandidate(
    id: 'candidate_mariam',
    fullName: 'مريم السيد',
    professionalTitle: 'محاسبة',
    categoryId: 'finance',
    experienceYears: 6,
    preferredLocation: 'دكرنس',
    desiredEmploymentType: EmploymentType.fullTime,
    summary: 'محاسبة خبرة.',
    availability: CandidateAvailability.openToOffers,
    publishedDaysAgo: 1,
    skills: ['Excel'],
  ),
  JobCandidate(
    id: 'candidate_sara',
    fullName: 'سارة فؤاد',
    professionalTitle: 'مصممة جرافيك',
    categoryId: 'technology',
    experienceYears: 2,
    preferredLocation: 'المنصورة',
    desiredEmploymentType: EmploymentType.partTime,
    summary: 'مصممة مبتكرة.',
    availability: CandidateAvailability.availableNow,
    publishedDaysAgo: 0,
    skills: ['Figma', 'Illustrator'],
  ),
];

const _catalog = JobsCatalog(
  categories: _categories,
  vacancies: _vacancies,
  candidates: _candidates,
);

void main() {
  late MockJobsRepository repository;

  setUp(() {
    repository = MockJobsRepository();
    when(
      () => repository.getJobsCatalog(force: any(named: 'force')),
    ).thenAnswer((_) async => _catalog);
  });

  blocTest<JobsCubit, JobsState>(
    'emits loading then a sorted success state',
    build: () => JobsCubit(repository),
    act: (cubit) => cubit.load(),
    expect: () => [
      isA<JobsState>().having(
        (state) => state.status,
        'status',
        JobsStatus.loading,
      ),
      isA<JobsState>()
          .having((state) => state.status, 'status', JobsStatus.success)
          .having((state) => state.categories, 'categories', _categories)
          .having((state) => state.vacancies, 'vacancies', [
            _vacancies[1],
            _vacancies[0],
            _vacancies[2],
          ])
          .having((state) => state.candidates, 'candidates', [
            _candidates[2],
            _candidates[1],
            _candidates[0],
          ]),
    ],
  );

  blocTest<JobsCubit, JobsState>(
    'maps loading errors to an application failure',
    build: () {
      when(
        () => repository.getJobsCatalog(force: any(named: 'force')),
      ).thenThrow(NetworkException());
      return JobsCubit(repository);
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      isA<JobsState>().having(
        (state) => state.status,
        'status',
        JobsStatus.loading,
      ),
      isA<JobsState>()
          .having((state) => state.status, 'status', JobsStatus.failure)
          .having(
            (state) => state.failure?.type,
            'failure type',
            FailureType.network,
          ),
    ],
  );

  test('filters vacancies and candidates by search query', () async {
    final cubit = JobsCubit(repository);
    addTearDown(cubit.close);

    await cubit.load();
    cubit.search('flutter');

    expect(cubit.state.query, 'flutter');
    expect(cubit.state.vacancies.map((item) => item.id), ['vacancy_flutter']);
    expect(cubit.state.candidates.map((item) => item.id), ['candidate_ahmed']);
  });

  test('combines category, employment type, and tab filters', () async {
    final cubit = JobsCubit(repository);
    addTearDown(cubit.close);

    await cubit.load();
    cubit
      ..selectCategory('technology')
      ..selectEmploymentType(EmploymentType.partTime);

    expect(cubit.state.vacancies.map((item) => item.id), ['vacancy_designer']);

    cubit.selectTab(JobsTab.candidates);

    expect(cubit.state.tab, JobsTab.candidates);
    expect(cubit.state.candidates.map((item) => item.id), [
      'candidate_sara',
      'candidate_ahmed',
    ]);

    cubit.selectAvailability(CandidateAvailability.availableNow);

    expect(cubit.state.candidates.map((item) => item.id), [
      'candidate_sara',
      'candidate_ahmed',
    ]);
  });

  test('sorts vacancies by salary', () async {
    final cubit = JobsCubit(repository);
    addTearDown(cubit.close);

    await cubit.load();
    cubit.selectSort(JobsSort.salaryHighLow);

    expect(cubit.state.vacancies.map((item) => item.id), [
      'vacancy_flutter',
      'vacancy_accountant',
      'vacancy_designer',
    ]);

    cubit.selectSort(JobsSort.salaryLowHigh);

    expect(cubit.state.vacancies.map((item) => item.id), [
      'vacancy_designer',
      'vacancy_accountant',
      'vacancy_flutter',
    ]);
  });

  test('sorts candidates by experience', () async {
    final cubit = JobsCubit(repository);
    addTearDown(cubit.close);

    await cubit.load();
    cubit
      ..selectTab(JobsTab.candidates)
      ..selectSort(JobsSort.experienceHigh);

    expect(cubit.state.candidates.map((item) => item.id), [
      'candidate_mariam',
      'candidate_ahmed',
      'candidate_sara',
    ]);
  });

  test('switching tabs does not reload the catalog', () async {
    final cubit = JobsCubit(repository);
    addTearDown(cubit.close);

    await cubit.load();
    cubit.selectTab(JobsTab.candidates);

    expect(cubit.state.tab, JobsTab.candidates);
    verify(
      () => repository.getJobsCatalog(force: any(named: 'force')),
    ).called(1);
  });

  test('clearFilters restores the default ordering and selections', () async {
    final cubit = JobsCubit(repository);
    addTearDown(cubit.close);

    await cubit.load();
    cubit
      ..selectCategory('technology')
      ..selectEmploymentType(EmploymentType.partTime)
      ..selectSort(JobsSort.salaryHighLow)
      ..search('مصمم');

    expect(cubit.state.hasActiveFilters, isTrue);

    cubit.clearFilters();

    expect(cubit.state.hasActiveFilters, isFalse);
    expect(cubit.state.sort, JobsSort.newest);
    expect(cubit.state.query, 'مصمم');
  });

  test('does not reload after a successful load, but refresh does', () async {
    var calls = 0;
    when(
      () => repository.getJobsCatalog(force: any(named: 'force')),
    ).thenAnswer((_) async {
      calls++;
      return _catalog;
    });

    final cubit = JobsCubit(repository);
    addTearDown(cubit.close);

    await cubit.load();
    await cubit.load();
    expect(calls, 1);

    await cubit.refresh();
    expect(calls, 2);
  });
}
