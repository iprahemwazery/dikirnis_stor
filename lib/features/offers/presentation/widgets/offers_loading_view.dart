import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_spacing.dart';

class OffersLoadingView extends StatelessWidget {
  const OffersLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.darkSurfaceMuted : const Color(0xFFE7ECF2),
      highlightColor: isDark ? AppColors.darkBorder : const Color(0xFFF8FAFC),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        itemCount: 4,
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) => const _OfferCardSkeleton(),
      ),
    );
  }
}

class _OfferCardSkeleton extends StatelessWidget {
  const _OfferCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 142,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Block(width: 100, height: 10, radius: 5),
                SizedBox(height: 8),
                _Block(height: 14, radius: 6),
                SizedBox(height: 6),
                _Block(width: 140, height: 14, radius: 6),
                Spacer(),
                _Block(width: 120, height: 9, radius: 5),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          const _Block(
            width: 118,
            height: double.infinity,
            radius: AppRadii.md,
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
