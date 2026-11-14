import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_shadows.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/offer.dart';
import 'offer_price.dart';

class OfferSummarySection extends StatelessWidget {
  const OfferSummarySection({
    super.key,
    required this.offer,
    required this.categoryName,
    required this.headingColor,
  });

  final Offer offer;
  final String? categoryName;
  final Color headingColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final localizations = MaterialLocalizations.of(context);
    final metadata = <Widget>[
      if (offer.expiresAt != null)
        _MetadataChip(
          icon: Icons.event_outlined,
          label: context.l10n.offersExpiresOn(
            localizations.formatMediumDate(offer.expiresAt!),
          ),
        ),
      if (offer.publishedAt != null)
        _MetadataChip(
          icon: Icons.schedule_rounded,
          label: context.l10n.offerDetailsPublishedLabel(
            localizations.formatMediumDate(offer.publishedAt!),
          ),
        ),
      if (offer.views > 0)
        _MetadataChip(
          icon: Icons.visibility_outlined,
          label: '${offer.views} ${context.l10n.offerDetailsViewsLabel}',
        ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.homeBorder,
        ),
        boxShadow: isDark ? const [] : AppShadows.card,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (categoryName != null) _CategoryPill(label: categoryName!),
              _AvailabilityPill(isAvailable: offer.isAvailable),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            offer.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: headingColor,
              fontWeight: FontWeight.w900,
              height: 1.3,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Icon(
                Icons.storefront_outlined,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  offer.businessName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (offer.seller.isVerified) ...[
                const SizedBox(width: 5),
                Icon(
                  Icons.verified_rounded,
                  size: 17,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 3),
                Text(
                  context.l10n.offerSellerVerified,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  formatOfferPrice(context, offer.price),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                  ),
                ),
              ),
              if (offer.hasOriginalPrice) ...[
                const SizedBox(width: AppSpacing.xs),
                Flexible(
                  child: Tooltip(
                    message: context.l10n.offerDetailsOriginalPriceLabel,
                    child: Text(
                      formatOfferPrice(context, offer.originalPrice!),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (metadata.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: metadata,
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Divider(
            height: 1,
            color: isDark ? AppColors.darkBorder : AppColors.homeBorder,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            context.l10n.productDetailsDescriptionTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              color: headingColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            offer.description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _AvailabilityPill extends StatelessWidget {
  const _AvailabilityPill({required this.isAvailable});

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    final color = isAvailable
        ? AppColors.promoGreenAccent
        : Theme.of(context).colorScheme.error;
    final background = isAvailable
        ? AppColors.promoGreen
        : Theme.of(context).colorScheme.errorContainer.withValues(alpha: 0.45);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAvailable ? Icons.check_circle_rounded : Icons.cancel_rounded,
            size: 13,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            isAvailable
                ? context.l10n.offerDetailsAvailable
                : context.l10n.offerDetailsUnavailable,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetadataChip extends StatelessWidget {
  const _MetadataChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
