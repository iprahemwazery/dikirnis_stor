import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/offer.dart';

class OfferAiGuidanceCard extends StatelessWidget {
  const OfferAiGuidanceCard({super.key, required this.offer});

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final hasStrongDiscount =
        offer.hasDiscount && (offer.discountPercent ?? 0) >= 20;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceMuted : AppColors.promoPurple,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.promoPurpleBorder,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: AppColors.promoPurpleAccent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColors.promoPurpleAccent,
                  size: 19,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  context.l10n.offerAiTitle,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: isDark
                        ? colorScheme.onSurface
                        : AppColors.promoPurpleAccent,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            hasStrongDiscount
                ? context.l10n.offerAiStrongDiscount
                : context.l10n.offerAiCompare,
            style: theme.textTheme.bodySmall?.copyWith(
              color: isDark
                  ? colorScheme.onSurfaceVariant
                  : colorScheme.onSurface,
              height: 1.55,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            context.l10n.offerAiPreviewNote,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
