import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/job_enums.dart';
import '../cubit/jobs_state.dart';
import '../jobs_localizations.dart';

class JobsFilterSelection {
  const JobsFilterSelection({
    this.employmentType,
    this.availability,
    this.sort = JobsSort.newest,
  });

  final EmploymentType? employmentType;
  final CandidateAvailability? availability;
  final JobsSort sort;
}

Future<JobsFilterSelection?> showJobsFilterSheet({
  required BuildContext context,
  required JobsTab tab,
  required EmploymentType? employmentType,
  required CandidateAvailability? availability,
  required JobsSort sort,
}) {
  return showModalBottomSheet<JobsFilterSelection>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return _JobsFilterSheet(
        tab: tab,
        initialEmploymentType: employmentType,
        initialAvailability: availability,
        initialSort: sort,
      );
    },
  );
}

class _JobsFilterSheet extends StatefulWidget {
  const _JobsFilterSheet({
    required this.tab,
    required this.initialEmploymentType,
    required this.initialAvailability,
    required this.initialSort,
  });

  final JobsTab tab;
  final EmploymentType? initialEmploymentType;
  final CandidateAvailability? initialAvailability;
  final JobsSort initialSort;

  @override
  State<_JobsFilterSheet> createState() => _JobsFilterSheetState();
}

class _JobsFilterSheetState extends State<_JobsFilterSheet> {
  late EmploymentType? _employmentType = widget.initialEmploymentType;
  late CandidateAvailability? _availability = widget.initialAvailability;
  late JobsSort _sort = widget.initialSort;

  bool get _isVacancies => widget.tab == JobsTab.vacancies;

  List<JobsSort> get _sortOptions => _isVacancies
      ? const [JobsSort.newest, JobsSort.salaryHighLow, JobsSort.salaryLowHigh]
      : const [JobsSort.newest, JobsSort.experienceHigh];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg + mediaQuery.viewInsets.bottom,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.jobsFilterSheetTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  _isVacancies
                      ? l10n.jobsFilterEmploymentType
                      : l10n.jobsFilterAvailability,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: _isVacancies
                      ? _employmentChips(l10n)
                      : _availabilityChips(l10n),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.jobsFilterSort,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: [
                    for (final sort in _sortOptions)
                      ChoiceChip(
                        key: ValueKey('jobs_filter_sort_${sort.name}'),
                        label: Text(sort.label(l10n)),
                        selected: _sort == sort,
                        onSelected: (_) => setState(() => _sort = sort),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        key: const ValueKey('jobs_filter_reset'),
                        onPressed: () {
                          setState(() {
                            _employmentType = null;
                            _availability = null;
                            _sort = JobsSort.newest;
                          });
                        },
                        child: Text(l10n.jobsReset),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: FilledButton(
                        key: const ValueKey('jobs_filter_apply'),
                        onPressed: () {
                          Navigator.of(context).pop(
                            JobsFilterSelection(
                              employmentType: _employmentType,
                              availability: _availability,
                              sort: _sort,
                            ),
                          );
                        },
                        child: Text(l10n.jobsApplyFilter),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _employmentChips(AppLocalizations l10n) {
    return [
      ChoiceChip(
        key: const ValueKey('jobs_filter_employment_all'),
        label: Text(l10n.jobsAllCategories),
        selected: _employmentType == null,
        onSelected: (_) => setState(() => _employmentType = null),
      ),
      for (final type in EmploymentType.values)
        ChoiceChip(
          key: ValueKey('jobs_filter_employment_${type.name}'),
          label: Text(type.label(l10n)),
          selected: _employmentType == type,
          onSelected: (_) => setState(() => _employmentType = type),
        ),
    ];
  }

  List<Widget> _availabilityChips(AppLocalizations l10n) {
    return [
      ChoiceChip(
        key: const ValueKey('jobs_filter_availability_all'),
        label: Text(l10n.jobsAllCategories),
        selected: _availability == null,
        onSelected: (_) => setState(() => _availability = null),
      ),
      for (final availability in CandidateAvailability.values)
        ChoiceChip(
          key: ValueKey('jobs_filter_availability_${availability.name}'),
          label: Text(availability.label(l10n)),
          selected: _availability == availability,
          onSelected: (_) => setState(() => _availability = availability),
        ),
    ];
  }
}
