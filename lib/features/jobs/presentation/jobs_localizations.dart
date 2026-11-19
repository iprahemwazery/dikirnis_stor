import '../../../l10n/l10n.dart';
import '../domain/entities/job_enums.dart';
import '../domain/entities/job_vacancy.dart';
import 'cubit/jobs_state.dart';

extension EmploymentTypeLocalization on EmploymentType {
  String label(AppLocalizations l10n) {
    return switch (this) {
      EmploymentType.fullTime => l10n.jobsEmploymentFullTime,
      EmploymentType.partTime => l10n.jobsEmploymentPartTime,
      EmploymentType.contract => l10n.jobsEmploymentContract,
      EmploymentType.internship => l10n.jobsEmploymentInternship,
      EmploymentType.freelance => l10n.jobsEmploymentFreelance,
    };
  }
}

extension SalaryPeriodLocalization on SalaryPeriod {
  String label(AppLocalizations l10n) {
    return switch (this) {
      SalaryPeriod.monthly => l10n.jobsSalaryPerMonth,
      SalaryPeriod.daily => l10n.jobsSalaryPerDay,
      SalaryPeriod.hourly => l10n.jobsSalaryPerHour,
      SalaryPeriod.yearly => l10n.jobsSalaryPerYear,
    };
  }
}

extension CandidateAvailabilityLocalization on CandidateAvailability {
  String label(AppLocalizations l10n) {
    return switch (this) {
      CandidateAvailability.availableNow => l10n.jobsAvailabilityNow,
      CandidateAvailability.openToOffers => l10n.jobsAvailabilityOpen,
    };
  }
}

extension JobsSortLocalization on JobsSort {
  String label(AppLocalizations l10n) {
    return switch (this) {
      JobsSort.newest => l10n.jobsSortNewest,
      JobsSort.salaryHighLow => l10n.jobsSortSalaryHigh,
      JobsSort.salaryLowHigh => l10n.jobsSortSalaryLow,
      JobsSort.experienceHigh => l10n.jobsSortExperienceHigh,
    };
  }
}

String formatSalary(JobVacancy vacancy, AppLocalizations l10n) {
  if (!vacancy.hasSalary) {
    return l10n.jobsSalaryNotDisclosed;
  }

  final min = vacancy.salaryMin;
  final max = vacancy.salaryMax;
  final currency = vacancy.salaryCurrency == 'EGP'
      ? l10n.currencyEgp
      : vacancy.salaryCurrency;

  final amount = min != null && max != null
      ? l10n.jobsSalaryRange(_formatAmount(min), _formatAmount(max), currency)
      : l10n.jobsSalaryFrom(_formatAmount(min ?? max!), currency);

  final period = vacancy.salaryPeriod;
  if (period == null) {
    return amount;
  }
  return '$amount · ${period.label(l10n)}';
}

String formatPostedDate(int daysAgo, AppLocalizations l10n) {
  if (daysAgo <= 0) {
    return l10n.jobsPublishedToday;
  }
  if (daysAgo == 1) {
    return l10n.jobsPublishedYesterday;
  }
  return l10n.jobsPublishedDaysAgo(daysAgo);
}

String _formatAmount(double value) {
  final rounded = value.round();
  final digits = rounded.abs().toString();
  final buffer = StringBuffer();
  for (var index = 0; index < digits.length; index++) {
    if (index > 0 && (digits.length - index) % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(digits[index]);
  }
  return rounded < 0 ? '-$buffer' : buffer.toString();
}
