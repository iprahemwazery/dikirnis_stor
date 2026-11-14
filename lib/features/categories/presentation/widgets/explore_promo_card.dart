import 'package:flutter/material.dart';

import '../../../../theme/app_radii.dart';
import '../../../../theme/app_shadows.dart';
import '../../../../theme/app_spacing.dart';

class ExplorePromoCard extends StatelessWidget {
  const ExplorePromoCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.background,
    required this.borderColor,
    required this.accentColor,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color background;
  final Color borderColor;
  final Color accentColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.md),
        boxShadow: isDark ? const [] : AppShadows.card,
      ),
      child: Material(
        color: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          side: BorderSide(color: borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(AppRadii.md),
                  ),
                  child: Icon(icon, size: 19, color: accentColor),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: accentColor,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 11,
                    height: 1.35,
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.16),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isRtl
                          ? Icons.chevron_left_rounded
                          : Icons.chevron_right_rounded,
                      size: 18,
                      color: accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
