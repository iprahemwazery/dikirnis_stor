import 'package:flutter/material.dart';

import '../../../../theme/app_spacing.dart';
import '../../domain/entities/home_category.dart';
import 'category_card.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  final List<HomeCategory> categories;
  final ValueChanged<HomeCategory> onCategoryTap;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final itemExtent = (100 + (textScale - 1) * 26).clamp(100.0, 160.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth >= 900
              ? 8
              : constraints.maxWidth >= 600
              ? 6
              : 4;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: AppSpacing.sm,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisExtent: itemExtent,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryCard(
                category: category,
                onTap: () => onCategoryTap(category),
              );
            },
          );
        },
      ),
    );
  }
}
