import 'package:flutter/material.dart';

import '../../../../core/widgets/app_asset_image.dart';
import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/offer.dart';
import 'offer_badges.dart';

class OfferImageGallery extends StatefulWidget {
  const OfferImageGallery({super.key, required this.offer});

  final Offer offer;

  @override
  State<OfferImageGallery> createState() => _OfferImageGalleryState();
}

class _OfferImageGalleryState extends State<OfferImageGallery> {
  late final PageController _controller;
  int _index = 0;

  List<String> get _images => widget.offer.galleryImages;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void didUpdateWidget(covariant OfferImageGallery oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.offer.id != widget.offer.id) {
      _index = 0;
      if (_controller.hasClients) {
        _controller.jumpToPage(0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.md,
        AppSpacing.xs,
        AppSpacing.md,
        0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        child: SizedBox(
          height: 286,
          child: Stack(
            fit: StackFit.expand,
            children: [
              PageView.builder(
                key: const ValueKey('offer_image_gallery'),
                controller: _controller,
                itemCount: _images.length,
                physics: _images.length > 1
                    ? const PageScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => setState(() => _index = index),
                itemBuilder: (context, index) {
                  return AppAssetImage(
                    assetPath: _images[index],
                    fit: BoxFit.cover,
                    semanticLabel: '${widget.offer.title} ${index + 1}',
                    fallbackIcon: Icons.shopping_bag_outlined,
                    placeholder: Container(
                      color: AppColors.tealSoft,
                      alignment: Alignment.center,
                      child: SizedBox.square(
                        dimension: 26,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (widget.offer.hasDiscount)
                PositionedDirectional(
                  top: AppSpacing.sm,
                  start: AppSpacing.sm,
                  child: OfferDiscountBadge(
                    percent: widget.offer.discountPercent!,
                  ),
                ),
              if (widget.offer.isFeatured)
                const PositionedDirectional(
                  top: AppSpacing.sm,
                  end: AppSpacing.sm,
                  child: OfferFeaturedBadge(),
                ),
              if (_images.length > 1)
                PositionedDirectional(
                  bottom: AppSpacing.sm,
                  end: AppSpacing.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.62),
                      borderRadius: BorderRadius.circular(AppRadii.pill),
                    ),
                    child: Text(
                      context.l10n.offerGalleryCounter(
                        _index + 1,
                        _images.length,
                      ),
                      textDirection: TextDirection.ltr,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
