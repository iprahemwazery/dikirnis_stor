import '../../domain/entities/job_enums.dart';
import '../../domain/entities/job_vacancy.dart';

class JobVacancyModel {
  const JobVacancyModel({
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

  factory JobVacancyModel.fromJson(Map<String, dynamic> json) {
    return JobVacancyModel(
      id: json['id'] as String,
      title: json['title'] as String,
      companyName: json['company_name'] as String,
      companyLogo: json['company_logo'] as String?,
      companyDescription: json['company_description'] as String?,
      categoryId: json['category_id'] as String,
      employmentType: EmploymentType.fromJson(
        json['employment_type'] as String?,
      ),
      location: json['location'] as String,
      publishedDaysAgo: (json['published_days_ago'] as num?)?.toInt() ?? 0,
      shortDescription: json['short_description'] as String? ?? '',
      description: json['description'] as String? ?? '',
      salaryMin: (json['salary_min'] as num?)?.toDouble(),
      salaryMax: (json['salary_max'] as num?)?.toDouble(),
      salaryCurrency: json['salary_currency'] as String? ?? 'EGP',
      salaryPeriod: SalaryPeriod.fromJson(json['salary_period'] as String?),
      responsibilities: _stringList(json['responsibilities']),
      requirements: _stringList(json['requirements']),
      experienceYears: (json['experience_years'] as num?)?.toInt(),
      contactPhone: json['contact_phone'] as String?,
      contactEmail: json['contact_email'] as String?,
      contactWhatsApp: json['contact_whatsapp'] as String?,
      applicationInstructions: json['application_instructions'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
      isFeatured: json['is_featured'] as bool? ?? false,
    );
  }

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

  JobVacancy toEntity() {
    return JobVacancy(
      id: id,
      title: title,
      companyName: companyName,
      companyLogo: companyLogo,
      companyDescription: companyDescription,
      categoryId: categoryId,
      employmentType: employmentType,
      location: location,
      publishedDaysAgo: publishedDaysAgo,
      shortDescription: shortDescription,
      description: description,
      salaryMin: salaryMin,
      salaryMax: salaryMax,
      salaryCurrency: salaryCurrency,
      salaryPeriod: salaryPeriod,
      responsibilities: List<String>.unmodifiable(responsibilities),
      requirements: List<String>.unmodifiable(requirements),
      experienceYears: experienceYears,
      contactPhone: contactPhone,
      contactEmail: contactEmail,
      contactWhatsApp: contactWhatsApp,
      applicationInstructions: applicationInstructions,
      isVerified: isVerified,
      isFeatured: isFeatured,
    );
  }
}

List<String> _stringList(Object? value) {
  if (value is! List) {
    return const [];
  }
  return value.whereType<String>().toList(growable: false);
}
