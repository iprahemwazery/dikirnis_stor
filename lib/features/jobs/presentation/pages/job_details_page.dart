import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_asset_image.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/job_vacancy.dart';
import '../cubit/job_details_cubit.dart';
import '../cubit/job_details_state.dart';
import '../jobs_localizations.dart';
import '../widgets/jobs_badge.dart';
import '../widgets/jobs_contact_actions.dart';
import '../widgets/jobs_detail_section.dart';

class JobDetailsPage extends StatelessWidget {
  const JobDetailsPage({super.key, required this.vacancyId});

  final String vacancyId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.jobsDetailsTitle,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<JobDetailsCubit, JobDetailsState>(
          builder: (context, state) {
            return switch (state.status) {
              JobDetailsStatus.initial || JobDetailsStatus.loading =>
                const Center(child: CircularProgressIndicator()),
              JobDetailsStatus.failure => AppErrorState(
                message: l10n.jobsErrorMessage,
                retryLabel: l10n.retry,
                onRetry: context.read<JobDetailsCubit>().refresh,
              ),
              JobDetailsStatus.success =>
                state.vacancy == null
                    ? AppEmptyState(
                        message: l10n.jobsDetailsNotFound,
                        icon: Icons.work_off_outlined,
                      )
                    : _VacancyDetails(
                        vacancy: state.vacancy!,
                        categoryName: state.category?.localizedName(
                          Localizations.localeOf(context).languageCode,
                        ),
                      ),
            };
          },
        ),
      ),
    );
  }
}

class _VacancyDetails extends StatelessWidget {
  const _VacancyDetails({required this.vacancy, this.categoryName});

  final JobVacancy vacancy;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: context.read<JobDetailsCubit>().refresh,
      color: theme.colorScheme.primary,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _VacancyHeader(vacancy: vacancy, categoryName: categoryName),
          const SizedBox(height: AppSpacing.lg),
          JobsDetailSection(
            title: l10n.jobsContactTitle,
            icon: Icons.contact_phone_outlined,
            child: JobsContactActions(
              phone: vacancy.contactPhone,
              whatsApp: vacancy.contactWhatsApp,
              email: vacancy.contactEmail,
            ),
          ),
          if (vacancy.description.isNotEmpty)
            JobsDetailSection(
              title: l10n.jobsDescriptionTitle,
              icon: Icons.description_outlined,
              child: Text(
                vacancy.description,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
              ),
            ),
          if (vacancy.responsibilities.isNotEmpty)
            JobsDetailSection(
              title: l10n.jobsResponsibilitiesTitle,
              icon: Icons.checklist_rounded,
              child: JobsBulletList(items: vacancy.responsibilities),
            ),
          if (vacancy.requirements.isNotEmpty)
            JobsDetailSection(
              title: l10n.jobsRequirementsTitle,
              icon: Icons.fact_check_outlined,
              child: JobsBulletList(items: vacancy.requirements),
            ),
          if (vacancy.companyDescription != null &&
              vacancy.companyDescription!.isNotEmpty)
            JobsDetailSection(
              title: l10n.jobsCompanyTitle,
              icon: Icons.business_outlined,
              child: Text(
                vacancy.companyDescription!,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
              ),
            ),
          if (vacancy.applicationInstructions != null &&
              vacancy.applicationInstructions!.isNotEmpty)
            JobsDetailSection(
              title: l10n.jobsApplyTitle,
              icon: Icons.send_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.jobsApplyInstructions,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    vacancy.applicationInstructions!,
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _VacancyHeader extends StatelessWidget {
  const _VacancyHeader({required this.vacancy, this.categoryName});

  final JobVacancy vacancy;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.homeBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeaderLogo(vacancy: vacancy),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vacancy.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vacancy.companyName,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              JobsBadge(
                label: vacancy.employmentType.label(l10n),
                icon: Icons.work_outline_rounded,
                backgroundColor: colorScheme.primaryContainer,
                foregroundColor: colorScheme.onPrimaryContainer,
              ),
              if (categoryName != null)
                JobsBadge(label: categoryName!, icon: Icons.category_outlined),
              if (vacancy.isFeatured)
                JobsBadge(
                  label: l10n.jobsFeaturedBadge,
                  icon: Icons.star_rounded,
                  backgroundColor: colorScheme.tertiaryContainer,
                  foregroundColor: colorScheme.onTertiaryContainer,
                ),
              if (vacancy.isVerified)
                JobsBadge(
                  label: l10n.jobsVerifiedEmployer,
                  icon: Icons.verified_rounded,
                  backgroundColor: AppColors.tealSoft,
                  foregroundColor: AppColors.primary,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _MetaRow(
            icon: Icons.location_on_outlined,
            label: l10n.jobsLocationLabel,
            value: vacancy.location,
          ),
          _MetaRow(
            icon: Icons.payments_outlined,
            label: l10n.jobsSalaryLabel,
            value: formatSalary(vacancy, l10n),
          ),
          if (vacancy.experienceYears != null)
            _MetaRow(
              icon: Icons.workspace_premium_outlined,
              label: l10n.jobsExperienceLabel,
              value: l10n.jobsExperienceYears(vacancy.experienceYears!),
            ),
          _MetaRow(
            icon: Icons.schedule_rounded,
            label: l10n.jobsPublishedLabel,
            value: formatPostedDate(vacancy.publishedDaysAgo, l10n),
          ),
        ],
      ),
    );
  }
}

class _HeaderLogo extends StatelessWidget {
  const _HeaderLogo({required this.vacancy});

  final JobVacancy vacancy;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final logo = vacancy.companyLogo;

    if (logo == null || logo.trim().isEmpty) {
      return Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Icon(Icons.business_rounded, color: colorScheme.primary),
      );
    }

    return AppAssetImage(
      assetPath: logo,
      width: 72,
      height: 72,
      fit: BoxFit.cover,
      borderRadius: BorderRadius.circular(16),
      fallbackIcon: Icons.business_rounded,
      semanticLabel: vacancy.companyName,
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: colorScheme.primary),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: value,
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
