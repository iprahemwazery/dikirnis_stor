import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_shadows.dart';
import '../../domain/entities/home_advertisement.dart';

class FeaturedAdvertisementCard extends StatelessWidget {
  const FeaturedAdvertisementCard({
    super.key,
    required this.advertisement,
    required this.onTap,
    required this.onDismiss,
  });

  final HomeAdvertisement advertisement;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  IconData get _logoIcon {
    return switch (advertisement.logoIconKey) {
      'storefront' => Icons.storefront_rounded,
      'restaurant' => Icons.restaurant_rounded,
      'medical' => Icons.medical_services_rounded,
      'services' => Icons.handyman_rounded,
      _ => Icons.campaign_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDark ? const [] : AppShadows.soft,
      ),
      child: Material(
        color: isDark ? AppColors.adBlueDark : AppColors.adBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isDark ? AppColors.adBlueBorderDark : AppColors.adBlueBorder,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(14, 14, 40, 14),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isDark
                            ? colorScheme.primary.withValues(alpha: 0.18)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(AppRadii.lg),
                      ),
                      child: Icon(
                        _logoIcon,
                        color: colorScheme.primary,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            advertisement.advertiserName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            advertisement.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PositionedDirectional(
                top: 2,
                end: 2,
                child: IconButton(
                  tooltip: context.l10n.advertisementCloseLabel,
                  onPressed: onDismiss,
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: colorScheme.onSurfaceVariant,
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
