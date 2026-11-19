import 'package:equatable/equatable.dart';

import 'job_enums.dart';

class CandidateExperience extends Equatable {
  const CandidateExperience({
    required this.role,
    required this.company,
    required this.startYear,
    this.endYear,
    this.summary,
  });

  final String role;
  final String company;
  final int startYear;
  final int? endYear;
  final String? summary;

  @override
  List<Object?> get props => [role, company, startYear, endYear, summary];
}

class CandidateEducation extends Equatable {
  const CandidateEducation({
    required this.degree,
    required this.institution,
    this.graduationYear,
  });

  final String degree;
  final String institution;
  final int? graduationYear;

  @override
  List<Object?> get props => [degree, institution, graduationYear];
}

class JobCandidate extends Equatable {
  const JobCandidate({
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

  bool get hasPhone => _hasText(contactPhone);

  bool get hasEmail => _hasText(contactEmail);

  bool get hasCv => _hasText(cvUrl);

  bool get hasContact => hasPhone || hasEmail;

  String get initials {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) {
      return '?';
    }
    if (parts.length == 1) {
      return parts.first.characters2;
    }
    return '${parts.first.characters2}${parts[1].characters2}';
  }

  @override
  List<Object?> get props => [
    id,
    fullName,
    professionalTitle,
    categoryId,
    image,
    experienceYears,
    preferredLocation,
    desiredEmploymentType,
    summary,
    availability,
    publishedDaysAgo,
    skills,
    experience,
    education,
    certificates,
    contactPhone,
    contactEmail,
    cvUrl,
    isVerified,
  ];
}

bool _hasText(String? value) => value != null && value.trim().isNotEmpty;

extension on String {
  String get characters2 => substring(0, 1).toUpperCase();
}
