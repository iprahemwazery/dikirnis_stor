import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../cubit/jobs_state.dart';

class JobsTabSelector extends StatelessWidget {
  const JobsTabSelector({
    super.key,
    required this.selectedTab,
    required this.onSelected,
  });

  final JobsTab selectedTab;
  final ValueChanged<JobsTab> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkSurfaceMuted
            : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              key: const ValueKey('jobs_tab_vacancies'),
              label: context.l10n.jobsVacanciesTab,
              isSelected: selectedTab == JobsTab.vacancies,
              onTap: () => onSelected(JobsTab.vacancies),
            ),
          ),
          const SizedBox(width: AppSpacing.xxs),
          Expanded(
            child: _TabButton(
              key: const ValueKey('jobs_tab_candidates'),
              label: context.l10n.jobsCandidatesTab,
              isSelected: selectedTab == JobsTab.candidates,
              onTap: () => onSelected(JobsTab.candidates),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Semantics(
      button: true,
      selected: isSelected,
      child: Material(
        color: isSelected ? colorScheme.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelLarge?.copyWith(
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
