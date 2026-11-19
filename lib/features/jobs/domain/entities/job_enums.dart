enum EmploymentType {
  fullTime,
  partTime,
  contract,
  internship,
  freelance;

  static EmploymentType fromJson(String? value) {
    return switch (value) {
      'part_time' => EmploymentType.partTime,
      'contract' => EmploymentType.contract,
      'internship' => EmploymentType.internship,
      'freelance' => EmploymentType.freelance,
      _ => EmploymentType.fullTime,
    };
  }
}

enum SalaryPeriod {
  monthly,
  daily,
  hourly,
  yearly;

  static SalaryPeriod? fromJson(String? value) {
    return switch (value) {
      'monthly' => SalaryPeriod.monthly,
      'daily' => SalaryPeriod.daily,
      'hourly' => SalaryPeriod.hourly,
      'yearly' => SalaryPeriod.yearly,
      _ => null,
    };
  }
}

enum CandidateAvailability {
  availableNow,
  openToOffers;

  static CandidateAvailability fromJson(String? value) {
    return switch (value) {
      'open_to_offers' => CandidateAvailability.openToOffers,
      _ => CandidateAvailability.availableNow,
    };
  }
}
