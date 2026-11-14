import 'package:flutter/material.dart';

import '../../../../core/widgets/app_asset_image.dart';
import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_shadows.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/offer.dart';
import 'offer_badges.dart';
import 'offer_price.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.offer,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
    this.categoryName,
    this.compact = false,
  });

  final Offer offer;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  final String? categoryName;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: compact ? 1.6 : 1.5,
                child: _OfferImage(
                  offer: offer,
                  isFavorite: isFavorite,
                  onFavoriteTap: onFavoriteTap,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.sm,
                  AppSpacing.xs,
                  AppSpacing.sm,
                  AppSpacing.sm,
                ),
                child: _OfferDetails(
                  offer: offer,
                  categoryName: categoryName,
                  compact: compact,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OfferDetails extends StatelessWidget {
  const _OfferDetails({
    required this.offer,
    required this.categoryName,
    required this.compact,
  });

  final Offer offer;
  final String? categoryName;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final titleColor = isDark ? colorScheme.onSurface : AppColors.darkTeal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (categoryName != null) ...[
          Text(
            categoryName!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.primary,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 3),
        ],
        Text(
          offer.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleSmall?.copyWith(
            color: titleColor,
            fontSize: compact ? 13 : 14,
            fontWeight: FontWeight.w800,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.storefront_outlined,
              size: 13,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                offer.businessName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (offer.seller.isVerified)
              Tooltip(
                message: context.l10n.offerSellerVerified,
                child: Icon(
                  Icons.verified_rounded,
                  size: 13,
                  color: colorScheme.primary,
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        OfferPrice(offer: offer, compact: compact),
      ],
    );
  }
}

class _OfferImage extends StatelessWidget {
  const _OfferImage({
    required this.offer,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  final Offer offer;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      fit: StackFit.expand,
      children: [
        AppAssetImage(
          assetPath: offer.image,
          fit: BoxFit.cover,
          semanticLabel: offer.title,
          fallbackIcon: Icons.shopping_bag_outlined,
          placeholder: Container(
            color: AppColors.tealSoft,
            alignment: Alignment.center,
            child: Icon(
              Icons.shopping_bag_outlined,
              color: colorScheme.primary,
              size: 30,
            ),
          ),
        ),
        if (!offer.isAvailable)
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black.withValues(alpha: 0.45),
              child: Center(
                child: Text(
                  context.l10n.offerDetailsUnavailable,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
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
          child: _FavoriteButton(isFavorite: isFavorite, onTap: onFavoriteTap),
        ),
      ],
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
