import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_asset_image.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/job_candidate.dart';
import '../cubit/job_details_cubit.dart';
import '../cubit/job_details_state.dart';
import '../jobs_localizations.dart';
import '../widgets/jobs_badge.dart';
import '../widgets/jobs_contact_actions.dart';
import '../widgets/jobs_detail_section.dart';

class CandidateDetailsPage extends StatelessWidget {
  const CandidateDetailsPage({super.key, required this.candidateId});

  final String candidateId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.jobsCandidateDetailsTitle,
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
                state.candidate == null
                    ? AppEmptyState(
                        message: l10n.jobsDetailsNotFound,
                        icon: Icons.person_off_outlined,
                      )
                    : _CandidateDetails(
                        candidate: state.candidate!,
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

class _CandidateDetails extends StatelessWidget {
  const _CandidateDetails({required this.candidate, this.categoryName});

  final JobCandidate candidate;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return RefreshIndicator(
      onRefresh: context.read<JobDetailsCubit>().refresh,
      color: colorScheme.primary,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _CandidateHeader(candidate: candidate, categoryName: categoryName),
          const SizedBox(height: AppSpacing.lg),
          if (candidate.summary.isNotEmpty)
            JobsDetailSection(
              title: l10n.jobsCandidateSummaryTitle,
              icon: Icons.notes_rounded,
              child: Text(
                candidate.summary,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
              ),
            ),
          if (candidate.skills.isNotEmpty)
            JobsDetailSection(
              title: l10n.jobsCandidateSkillsTitle,
              icon: Icons.auto_awesome_outlined,
              child: Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  for (final skill in candidate.skills) JobsBadge(label: skill),
                ],
              ),
            ),
          if (candidate.experience.isNotEmpty)
            JobsDetailSection(
              title: l10n.jobsCandidateExperienceTitle,
              icon: Icons.work_history_outlined,
              child: Column(
                children: [
                  for (final entry in candidate.experience)
                    _ExperienceTile(entry: entry),
                ],
              ),
            ),
          if (candidate.education.isNotEmpty)
            JobsDetailSection(
              title: l10n.jobsCandidateEducationTitle,
              icon: Icons.school_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final entry in candidate.education)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        bottom: AppSpacing.xs,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.degree,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            [
                              entry.institution,
                              if (entry.graduationYear != null)
                                '${entry.graduationYear}',
                            ].join(' · '),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          if (candidate.certificates.isNotEmpty)
            JobsDetailSection(
              title: l10n.jobsCandidateCertificatesTitle,
              icon: Icons.workspace_premium_outlined,
              child: Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  for (final certificate in candidate.certificates)
                    JobsBadge(label: certificate),
                ],
              ),
            ),
          JobsDetailSection(
            title: l10n.jobsContactTitle,
            icon: Icons.contact_phone_outlined,
            child: JobsContactActions(
              phone: candidate.contactPhone,
              email: candidate.contactEmail,
            ),
          ),
          JobsDetailSection(
            title: l10n.jobsCandidateCvTitle,
            icon: Icons.attach_file_rounded,
            child: candidate.hasCv
                ? _CvTile(url: candidate.cvUrl!)
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      l10n.jobsCandidateCvUnavailable,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _CandidateHeader extends StatelessWidget {
  const _CandidateHeader({required this.candidate, this.categoryName});

  final JobCandidate candidate;
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
              _CandidateAvatar(candidate: candidate),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            candidate.fullName,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              height: 1.25,
                            ),
                          ),
                        ),
                        if (candidate.isVerified) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified_rounded,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      candidate.professionalTitle,
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
                label: candidate.availability.label(l10n),
                icon: Icons.check_circle_outline_rounded,
                backgroundColor: colorScheme.primaryContainer,
                foregroundColor: colorScheme.onPrimaryContainer,
              ),
              if (categoryName != null)
                JobsBadge(label: categoryName!, icon: Icons.category_outlined),
              JobsBadge(
                label: candidate.desiredEmploymentType.label(l10n),
                icon: Icons.work_outline_rounded,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _MetaRow(
            icon: Icons.workspace_premium_outlined,
            label: l10n.jobsExperienceLabel,
            value: l10n.jobsExperienceYears(candidate.experienceYears),
          ),
          _MetaRow(
            icon: Icons.location_on_outlined,
            label: l10n.jobsCandidatePreferredLocationLabel,
            value: candidate.preferredLocation,
          ),
          _MetaRow(
            icon: Icons.schedule_rounded,
            label: l10n.jobsPublishedLabel,
            value: formatPostedDate(candidate.publishedDaysAgo, l10n),
          ),
        ],
      ),
    );
  }
}

class _CandidateAvatar extends StatelessWidget {
  const _CandidateAvatar({required this.candidate});

  final JobCandidate candidate;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final image = candidate.image;

    if (image == null || image.trim().isEmpty) {
      return Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          candidate.initials,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w800,
          ),
        ),
      );
    }

    return AppAssetImage(
      assetPath: image,
      width: 72,
      height: 72,
      fit: BoxFit.cover,
      borderRadius: BorderRadius.circular(36),
      fallbackIcon: Icons.person_rounded,
      semanticLabel: candidate.fullName,
    );
  }
}

class _ExperienceTile extends StatelessWidget {
  const _ExperienceTile({required this.entry});

  final CandidateExperience entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;
    final period = l10n.jobsFromTo(
      '${entry.startYear}',
      entry.endYear?.toString() ?? l10n.jobsPresent,
    );

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.role,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '${entry.company} · $period',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          if (entry.summary != null && entry.summary!.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              entry.summary!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CvTile extends StatelessWidget {
  const _CvTile({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: url));
          if (!context.mounted) {
            return;
          }
          final messenger = ScaffoldMessenger.of(context);
          messenger
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(context.l10n.jobsContactCopied)),
            );
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            children: [
              Icon(Icons.description_outlined, color: colorScheme.primary),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  url,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Icon(
                Icons.copy_rounded,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
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
