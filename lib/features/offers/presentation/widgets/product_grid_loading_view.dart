import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';

class ProductGridLoadingView extends StatelessWidget {
  const ProductGridLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.darkSurfaceMuted : const Color(0xFFE7ECF2),
      highlightColor: isDark ? AppColors.darkBorder : const Color(0xFFF8FAFC),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 230,
          mainAxisExtent: 330,
          crossAxisSpacing: AppSpacing.sm,
          mainAxisSpacing: AppSpacing.sm,
        ),
        itemCount: 6,
        itemBuilder: (context, index) => const _ProductCardSkeleton(),
      ),
    );
  }
}

class _ProductCardSkeleton extends StatelessWidget {
  const _ProductCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Block(height: 138, radius: 0),
          Padding(
            padding: EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Block(width: 70, height: 8, radius: 4),
                SizedBox(height: 8),
                _Block(height: 13, radius: 6),
                SizedBox(height: 6),
                _Block(width: 110, height: 13, radius: 6),
                SizedBox(height: 12),
                _Block(width: 95, height: 9, radius: 5),
                SizedBox(height: 20),
                _Block(width: 85, height: 15, radius: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Block extends StatelessWidget {
  const _Block({this.width, required this.height, this.radius = 8});

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
