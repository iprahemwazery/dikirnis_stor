abstract final class AppRoutes {
  static const String home = '/';
  static const String explore = '/explore';
  static const String offers = '/offers';
  static const String offerDetails = '$offers/:offerId';
  static const String marketplace = '/marketplace';
  static const String productDetails = '$marketplace/:offerId';
  static const String profile = '/profile';
  static const String settings = '$profile/settings';
  static const String businesses = '/businesses';
  static const String businessCreate = '$businesses/create';
  static const String businessDetails = '$businesses/:businessId';
  static const String jobs = '/jobs';
  static const String jobVacancyDetails = '$jobs/vacancies/:jobId';
  static const String jobCandidateDetails = '$jobs/candidates/:candidateId';
  static const String jobCreate = '$jobs/create';

  static String offerDetailsPath(String offerId) {
    return '$offers/${Uri.encodeComponent(offerId)}';
  }

  static String productDetailsPath(String offerId) {
    return '$marketplace/${Uri.encodeComponent(offerId)}';
  }

  static String businessDirectoryPath(String section) {
    return '$businesses?section=${Uri.encodeQueryComponent(section)}';
  }

  static String businessCreatePath(String categoryId) {
    return '$businessCreate?category=${Uri.encodeQueryComponent(categoryId)}';
  }

  static String businessDetailsPath(String businessId) {
    return '$businesses/${Uri.encodeComponent(businessId)}';
  }

  static String jobVacancyDetailsPath(String jobId) {
    return '$jobs/vacancies/${Uri.encodeComponent(jobId)}';
  }

  static String jobCandidateDetailsPath(String candidateId) {
    return '$jobs/candidates/${Uri.encodeComponent(candidateId)}';
  }

  static String jobCreatePath(String tab) {
    return '$jobCreate?tab=${Uri.encodeQueryComponent(tab)}';
  }
}
