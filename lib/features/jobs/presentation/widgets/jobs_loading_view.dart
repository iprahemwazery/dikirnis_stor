import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';

class JobsLoadingView extends StatelessWidget {
  const JobsLoadingView({super.key});

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
        itemBuilder: (context, index) => const _JobCardSkeleton(),
      ),
    );
  }
}

class _JobCardSkeleton extends StatelessWidget {
  const _JobCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 196,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Block(width: 54, height: 54, radius: 14),
              SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Block(width: 180, height: 14, radius: 7),
                    SizedBox(height: 8),
                    _Block(width: 120, height: 10, radius: 5),
                    SizedBox(height: 8),
                    _Block(width: 150, height: 9, radius: 5),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          _Block(width: 90, height: 20, radius: 10),
          SizedBox(height: AppSpacing.sm),
          _Block(height: 10, radius: 5),
          SizedBox(height: 6),
          _Block(width: 200, height: 10, radius: 5),
          Spacer(),
          _Block(width: 160, height: 12, radius: 6),
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
