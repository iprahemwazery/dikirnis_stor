import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_shadows.dart';
import '../../../../theme/category_visuals.dart';
import '../../domain/entities/home_category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category, required this.onTap});

  final HomeCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final visual = category.isMore
        ? const CategoryVisual(
            icon: Icons.add_rounded,
            background: AppColors.tealSoft,
            foreground: AppColors.primary,
          )
        : categoryVisualFor(category.iconKey);
    final borderColor = category.isMore
        ? colorScheme.primary.withValues(alpha: 0.45)
        : (isDark ? AppColors.darkBorder : AppColors.homeBorder);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        boxShadow: isDark ? const [] : AppShadows.card,
      ),
      child: Material(
        color: category.isMore
            ? colorScheme.primary.withValues(alpha: 0.07)
            : colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
          side: BorderSide(color: borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: visual.background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(visual.icon, size: 21, color: visual.foreground),
                ),
                const SizedBox(height: 6),
                Text(
                  category.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: category.isMore
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
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
