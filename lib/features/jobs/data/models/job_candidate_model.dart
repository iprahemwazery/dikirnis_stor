import '../../domain/entities/job_candidate.dart';
import '../../domain/entities/job_enums.dart';

class JobCandidateModel {
  const JobCandidateModel({
    required this.id,
    required this.fullName,
    required this.professionalTitle,
    required this.categoryId,
    required this.experienceYears,
    required this.preferredLocation,
    required this.desiredEmploymentType,
    required this.summary,
    required this.availability,
    required this.publishedDaysAgo,
    this.image,
    this.skills = const [],
    this.experience = const [],
    this.education = const [],
    this.certificates = const [],
    this.contactPhone,
    this.contactEmail,
    this.cvUrl,
    this.isVerified = false,
  });

  factory JobCandidateModel.fromJson(Map<String, dynamic> json) {
    return JobCandidateModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      professionalTitle: json['professional_title'] as String,
      categoryId: json['category_id'] as String,
      image: json['image'] as String?,
      experienceYears: (json['experience_years'] as num?)?.toInt() ?? 0,
      preferredLocation: json['preferred_location'] as String? ?? '',
      desiredEmploymentType: EmploymentType.fromJson(
        json['desired_employment_type'] as String?,
      ),
      summary: json['summary'] as String? ?? '',
      availability: CandidateAvailability.fromJson(
        json['availability'] as String?,
      ),
      publishedDaysAgo: (json['published_days_ago'] as num?)?.toInt() ?? 0,
      skills: _stringList(json['skills']),
      experience: _experienceList(json['experience']),
      education: _educationList(json['education']),
      certificates: _stringList(json['certificates']),
      contactPhone: json['contact_phone'] as String?,
      contactEmail: json['contact_email'] as String?,
      cvUrl: json['cv_url'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
    );
  }

  final String id;
  final String fullName;
  final String professionalTitle;
  final String categoryId;
  final String? image;
  final int experienceYears;
  final String preferredLocation;
  final EmploymentType desiredEmploymentType;
  final String summary;
  final CandidateAvailability availability;
  final int publishedDaysAgo;
  final List<String> skills;
  final List<CandidateExperience> experience;
  final List<CandidateEducation> education;
  final List<String> certificates;
  final String? contactPhone;
  final String? contactEmail;
  final String? cvUrl;
  final bool isVerified;

  JobCandidate toEntity() {
    return JobCandidate(
      id: id,
      fullName: fullName,
      professionalTitle: professionalTitle,
      categoryId: categoryId,
      image: image,
      experienceYears: experienceYears,
      preferredLocation: preferredLocation,
      desiredEmploymentType: desiredEmploymentType,
      summary: summary,
      availability: availability,
      publishedDaysAgo: publishedDaysAgo,
      skills: List<String>.unmodifiable(skills),
      experience: List<CandidateExperience>.unmodifiable(experience),
      education: List<CandidateEducation>.unmodifiable(education),
      certificates: List<String>.unmodifiable(certificates),
      contactPhone: contactPhone,
      contactEmail: contactEmail,
      cvUrl: cvUrl,
      isVerified: isVerified,
    );
  }
}

List<String> _stringList(Object? value) {
  if (value is! List) {
    return const [];
  }
  return value.whereType<String>().toList(growable: false);
}

List<CandidateExperience> _experienceList(Object? value) {
  if (value is! List) {
    return const [];
  }
  return value
      .whereType<Map<String, dynamic>>()
      .map((json) {
        return CandidateExperience(
          role: json['role'] as String? ?? '',
          company: json['company'] as String? ?? '',
          startYear: (json['start_year'] as num?)?.toInt() ?? 0,
          endYear: (json['end_year'] as num?)?.toInt(),
          summary: json['summary'] as String?,
        );
      })
      .toList(growable: false);
}

List<CandidateEducation> _educationList(Object? value) {
  if (value is! List) {
    return const [];
  }
  return value
      .whereType<Map<String, dynamic>>()
      .map((json) {
        return CandidateEducation(
          degree: json['degree'] as String? ?? '',
          institution: json['institution'] as String? ?? '',
          graduationYear: (json['graduation_year'] as num?)?.toInt(),
        );
      })
      .toList(growable: false);
}
