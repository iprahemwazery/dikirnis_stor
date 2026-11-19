import 'package:equatable/equatable.dart';

import 'job_enums.dart';

class JobVacancy extends Equatable {
  const JobVacancy({
    required this.id,
    required this.title,
    required this.companyName,
    required this.categoryId,
    required this.employmentType,
    required this.location,
    required this.publishedDaysAgo,
    required this.shortDescription,
    required this.description,
    this.companyLogo,
    this.companyDescription,
    this.salaryMin,
    this.salaryMax,
    this.salaryCurrency = 'EGP',
    this.salaryPeriod,
    this.responsibilities = const [],
    this.requirements = const [],
    this.experienceYears,
    this.contactPhone,
    this.contactEmail,
    this.contactWhatsApp,
    this.applicationInstructions,
    this.isVerified = false,
    this.isFeatured = false,
  });

  final String id;
  final String title;
  final String companyName;
  final String? companyLogo;
  final String? companyDescription;
  final String categoryId;
  final EmploymentType employmentType;
  final String location;
  final int publishedDaysAgo;
  final String shortDescription;
  final String description;
  final double? salaryMin;
  final double? salaryMax;
  final String salaryCurrency;
  final SalaryPeriod? salaryPeriod;
  final List<String> responsibilities;
  final List<String> requirements;
  final int? experienceYears;
  final String? contactPhone;
  final String? contactEmail;
  final String? contactWhatsApp;
  final String? applicationInstructions;
  final bool isVerified;
  final bool isFeatured;

  bool get hasSalary => salaryMin != null || salaryMax != null;

  bool get hasPhone => _hasText(contactPhone);

  bool get hasEmail => _hasText(contactEmail);

  bool get hasWhatsApp => _hasText(contactWhatsApp);

  bool get hasContact => hasPhone || hasEmail || hasWhatsApp;

  @override
  List<Object?> get props => [
    id,
    title,
    companyName,
    companyLogo,
    companyDescription,
    categoryId,
    employmentType,
    location,
    publishedDaysAgo,
    shortDescription,
    description,
    salaryMin,
    salaryMax,
    salaryCurrency,
    salaryPeriod,
    responsibilities,
    requirements,
    experienceYears,
    contactPhone,
    contactEmail,
    contactWhatsApp,
    applicationInstructions,
    isVerified,
    isFeatured,
  ];
}

bool _hasText(String? value) => value != null && value.trim().isNotEmpty;
