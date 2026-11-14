import 'package:flutter/material.dart';

import '../../../../core/widgets/app_asset_image.dart';
import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_shadows.dart';
import '../../domain/entities/business.dart';
import 'business_badge.dart';
import 'rating_badge.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({
    super.key,
    required this.business,
    required this.imageHeight,
    required this.onTap,
    this.showDescription = false,
    this.showViews = false,
  });

  final Business business;
  final double imageHeight;
  final VoidCallback onTap;
  final bool showDescription;
  final bool showViews;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      key: ValueKey('business_${business.id}'),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: isDark ? const [] : AppShadows.soft,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: imageHeight,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AppAssetImage(
                      assetPath: business.image,
                      fit: BoxFit.cover,
                      semanticLabel: business.name,
                    ),
                    if (business.rank != null)
                      PositionedDirectional(
                        top: 8,
                        start: 8,
                        child: _RankBadge(rank: business.rank!),
                      )
                    else if (business.isNew)
                      const PositionedDirectional(
                        top: 8,
                        start: 8,
                        child: NewBusinessBadge(),
                      ),
                    if (business.isSponsored)
                      const PositionedDirectional(
                        top: 8,
                        end: 8,
                        child: SponsoredBadge(),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 9, 10, 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        business.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: colorScheme.onSurface,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 12,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              business.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontSize: 10.5,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (showDescription &&
                          business.description != null &&
                          business.description!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Flexible(
                          child: Text(
                            business.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 10.5,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                      const Spacer(),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          RatingBadge(rating: business.rating),
                          if (showViews && business.views > 0)
                            _ViewsCount(views: business.views),
                          if (business.isVerified) const VerifiedBadge(),
                        ],
                      ),
                    ],
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

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.rank});

  final int rank;

  Color get _color => switch (rank) {
    1 => const Color(0xFFE59A17),
    2 => const Color(0xFF8C97A8),
    3 => const Color(0xFFB87333),
    _ => AppColors.primary,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 27,
      height: 27,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        '$rank',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          height: 1,
        ),
      ),
    );
  }
}

class _ViewsCount extends StatelessWidget {
  const _ViewsCount({required this.views});

  final int views;

  String _formatViews(BuildContext context) {
    if (views < 1000) {
      return '$views';
    }
    final value = views / 1000;
    final formatted = value >= 10
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(1);
    return Localizations.localeOf(context).languageCode == 'ar'
        ? '$formatted ألف'
        : '${formatted}K';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.visibility_outlined,
          size: 12,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 3),
        Text(
          '${_formatViews(context)} ${context.l10n.viewsLabel}',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontSize: 9.5,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
        ),
      ],
    );
  }
}
