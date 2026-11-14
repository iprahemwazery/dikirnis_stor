import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_shadows.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/user_profile.dart';

class ProfileStatsCard extends StatelessWidget {
  const ProfileStatsCard({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.homeBorder,
        ),
        boxShadow: isDark ? const [] : AppShadows.card,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.md,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _Stat(
                value: profile.ordersCount,
                label: context.l10n.profileOrdersStat,
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: _Stat(
                value: profile.favoritesCount,
                label: context.l10n.profileFavoritesStat,
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: _Stat(
                value: profile.reviewsCount,
                label: context.l10n.profileReviewsStat,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$value',
          style: theme.textTheme.titleLarge?.copyWith(
            color: isDark ? colorScheme.primary : AppColors.darkTeal,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
