import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_asset_image.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../home/domain/entities/business.dart';
import '../../../home/presentation/widgets/business_badge.dart';
import '../../../home/presentation/widgets/rating_badge.dart';
import '../cubit/business_details_cubit.dart';
import '../cubit/business_details_state.dart';

class BusinessDetailsPage extends StatelessWidget {
  const BusinessDetailsPage({super.key, required this.businessId});

  final String businessId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.businessDetailsTitle,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<BusinessDetailsCubit, BusinessDetailsState>(
          builder: (context, state) {
            return switch (state.status) {
              BusinessDetailsStatus.initial || BusinessDetailsStatus.loading =>
                const Center(child: CircularProgressIndicator()),
              BusinessDetailsStatus.notFound => AppEmptyState(
                message: l10n.businessesNotFound,
                icon: Icons.storefront_outlined,
              ),
              BusinessDetailsStatus.failure => AppErrorState(
                message: l10n.businessesErrorMessage,
                retryLabel: l10n.retry,
                onRetry: () => context.read<BusinessDetailsCubit>().refresh(),
              ),
              BusinessDetailsStatus.success => _BusinessDetailsBody(
                business: state.business!,
                onRefresh: context.read<BusinessDetailsCubit>().refresh,
              ),
            };
          },
        ),
      ),
    );
  }
}

class _BusinessDetailsBody extends StatelessWidget {
  const _BusinessDetailsBody({required this.business, required this.onRefresh});

  final Business business;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: colorScheme.primary,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 220,
              width: double.infinity,
              child: AppAssetImage(
                assetPath: business.image,
                fit: BoxFit.cover,
                semanticLabel: business.name,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            business.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              RatingBadge(rating: business.rating),
              if (business.views > 0)
                _InfoPill(
                  icon: Icons.visibility_outlined,
                  label: '${business.views} ${l10n.viewsLabel}',
                ),
              if (business.isVerified) const VerifiedBadge(),
              if (business.isSponsored) const SponsoredBadge(),
              if (business.isNew) const NewBusinessBadge(),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  business.location,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          if (business.description != null &&
              business.description!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            _BusinessSection(
              title: l10n.businessAboutTitle,
              child: Text(
                business.description!,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          _BusinessSection(
            title: l10n.businessLocationTitle,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(business.location, style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.xs),
                _UnavailableNote(
                  icon: Icons.map_outlined,
                  message: l10n.businessMapUnavailable,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _BusinessSection(
            title: l10n.businessContactTitle,
            child: _UnavailableNote(
              icon: Icons.contact_phone_outlined,
              message: l10n.businessContactUnavailable,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _BusinessSection extends StatelessWidget {
  const _BusinessSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? AppColors.darkBorder
              : AppColors.homeBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          child,
        ],
      ),
    );
  }
}

class _UnavailableNote extends StatelessWidget {
  const _UnavailableNote({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            message,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 3),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
