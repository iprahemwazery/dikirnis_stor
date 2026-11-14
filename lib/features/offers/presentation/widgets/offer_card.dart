import 'package:flutter/material.dart';

import '../../../../core/widgets/app_asset_image.dart';
import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_shadows.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/offer.dart';
import 'offer_badges.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
    required this.offer,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });

  final Offer offer;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final cardHeight = (118 + (textScale - 1) * 95).clamp(118.0, 230.0);
    final imageWidth = (118 + (textScale - 1) * 35).clamp(118.0, 170.0);

    return Container(
      key: ValueKey('offer_${offer.id}'),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: isDark ? const [] : AppShadows.card,
      ),
      child: Material(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.homeBorder,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: SizedBox(
              height: cardHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _OfferDetails(offer: offer)),
                  const SizedBox(width: AppSpacing.sm),
                  _OfferImage(
                    offer: offer,
                    width: imageWidth,
                    isFavorite: isFavorite,
                    onFavoriteTap: onFavoriteTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OfferDetails extends StatelessWidget {
  const _OfferDetails({required this.offer});

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final titleColor = isDark ? colorScheme.onSurface : AppColors.darkTeal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          offer.businessName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.primary,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          offer.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleSmall?.copyWith(
            color: titleColor,
            fontSize: 14.5,
            fontWeight: FontWeight.w800,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          offer.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontSize: 10.5,
            height: 1.35,
          ),
        ),
        const Spacer(),
        _OfferMetadata(offer: offer),
      ],
    );
  }
}

class _OfferMetadata extends StatelessWidget {
  const _OfferMetadata({required this.offer});

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final items = <Widget>[];

    if (offer.hasDiscount) {
      items.add(
        _MetadataItem(
          icon: Icons.local_offer_outlined,
          label: context.l10n.offersDiscountValue(offer.discountPercent!),
          color: const Color(0xFFD84A4A),
        ),
      );
    }

    if (offer.expiresAt != null) {
      final date = MaterialLocalizations.of(
        context,
      ).formatMediumDate(offer.expiresAt!);
      items.add(
        _MetadataItem(
          icon: Icons.event_outlined,
          label: context.l10n.offersExpiresOn(date),
          color: colorScheme.onSurfaceVariant,
        ),
      );
    }

    if (offer.views > 0) {
      items.add(
        _MetadataItem(
          icon: Icons.visibility_outlined,
          label: '${_formatViews(offer.views)} ${context.l10n.viewsLabel}',
          color: colorScheme.onSurfaceVariant,
        ),
      );
    }

    return Wrap(spacing: AppSpacing.sm, runSpacing: 2, children: items);
  }

  String _formatViews(int views) {
    if (views < 1000) {
      return '$views';
    }
    final value = views / 1000;
    return value >= 10 ? value.toStringAsFixed(0) : value.toStringAsFixed(1);
  }
}

class _MetadataItem extends StatelessWidget {
  const _MetadataItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 3),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              height: 1.1,
            ),
          ),
        ),
      ],
    );
  }
}

class _OfferImage extends StatelessWidget {
  const _OfferImage({
    required this.offer,
    required this.width,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  final Offer offer;
  final double width;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppAssetImage(
              assetPath: offer.image,
              fit: BoxFit.cover,
              semanticLabel: offer.businessName,
              fallbackIcon: Icons.local_offer_outlined,
              placeholder: Container(
                color: AppColors.tealSoft,
                alignment: Alignment.center,
                child: Icon(
                  Icons.local_offer_outlined,
                  color: colorScheme.primary,
                  size: 24,
                ),
              ),
            ),
            if (offer.hasDiscount)
              PositionedDirectional(
                top: 6,
                start: 6,
                child: OfferDiscountBadge(
                  percent: offer.discountPercent!,
                  compact: true,
                ),
              ),
            if (offer.isFeatured)
              const PositionedDirectional(
                bottom: 6,
                start: 6,
                child: OfferFeaturedBadge(),
              ),
            PositionedDirectional(
              top: 6,
              end: 6,
              child: _FavoriteButton(
                isFavorite: isFavorite,
                onTap: onFavoriteTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.isFavorite, required this.onTap});

  final bool isFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: isFavorite
          ? context.l10n.offersRemoveFavorite
          : context.l10n.offersAddFavorite,
      child: Material(
        color: Colors.white.withValues(alpha: 0.95),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox.square(
            dimension: 32,
            child: Icon(
              isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              size: 18,
              color: isFavorite
                  ? const Color(0xFFE45757)
                  : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
