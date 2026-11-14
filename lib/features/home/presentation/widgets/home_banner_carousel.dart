import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/widgets/app_asset_image.dart';
import '../../../../l10n/l10n.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/home_banner.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({
    super.key,
    required this.banners,
    required this.onBannerTap,
    required this.onMoreTap,
  });

  final List<HomeBanner> banners;
  final ValueChanged<HomeBanner> onBannerTap;
  final VoidCallback onMoreTap;

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  static const Duration _autoScrollInterval = Duration(seconds: 5);
  static const Duration _autoScrollAnimation = Duration(milliseconds: 450);
  static const int _initialPageMultiplier = 1000;

  late final PageController _pageController;
  Timer? _autoScrollTimer;
  bool _isUserInteracting = false;
  int _currentPage = 0;

  int get _initialPage => widget.banners.isEmpty
      ? 0
      : widget.banners.length * _initialPageMultiplier;

  @override
  void initState() {
    super.initState();
    _currentPage = _initialPage;
    _pageController = PageController(initialPage: _currentPage);
    _startAutoScroll();
  }

  @override
  void didUpdateWidget(covariant HomeBannerCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.banners.length != widget.banners.length) {
      _currentPage = _initialPage;
      _startAutoScroll();
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    if (widget.banners.length <= 1) {
      return;
    }
    _autoScrollTimer = Timer.periodic(_autoScrollInterval, (_) {
      if (!mounted || !_pageController.hasClients) {
        return;
      }
      _pageController.animateToPage(
        _currentPage + 1,
        duration: _autoScrollAnimation,
        curve: Curves.easeInOut,
      );
    });
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification &&
        notification.dragDetails != null) {
      _isUserInteracting = true;
      _autoScrollTimer?.cancel();
    } else if (notification is ScrollEndNotification && _isUserInteracting) {
      _isUserInteracting = false;
      _startAutoScroll();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    final activePage = _currentPage % widget.banners.length;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 2.05,
            child: NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final banner = widget.banners[index % widget.banners.length];
                  return _BannerCard(
                    banner: banner,
                    onTap: () => widget.onBannerTap(banner),
                    onMoreTap: widget.onMoreTap,
                  );
                },
              ),
            ),
          ),
          if (widget.banners.length > 1) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.banners.length, (index) {
                final isActive = index == activePage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  width: isActive ? 18 : 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: isActive
                        ? colorScheme.primary
                        : colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(AppRadii.pill),
                  ),
                );
              }),
            ),
          ],
        ],
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({
    required this.banner,
    required this.onTap,
    required this.onMoreTap,
  });

  final HomeBanner banner;
  final VoidCallback onTap;
  final VoidCallback onMoreTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppAssetImage(
              assetPath: banner.image,
              fit: BoxFit.cover,
              fallbackIcon: Icons.image_outlined,
              semanticLabel: banner.title,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x12000000),
                    Color(0x1F000000),
                    Color(0xD9000000),
                  ],
                  stops: [0, 0.45, 1],
                ),
              ),
            ),
            PositionedDirectional(
              start: AppSpacing.lg,
              end: AppSpacing.lg,
              bottom: AppSpacing.md,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          banner.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          banner.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.86),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Material(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppRadii.pill),
                    child: InkWell(
                      onTap: onMoreTap,
                      borderRadius: BorderRadius.circular(AppRadii.pill),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.l10n.moreLabel,
                              style: textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Icon(
                              Directionality.of(context) == TextDirection.rtl
                                  ? Icons.chevron_left_rounded
                                  : Icons.chevron_right_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
