import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.darkSurfaceMuted : const Color(0xFFE7ECF2),
      highlightColor: isDark ? AppColors.darkBorder : const Color(0xFFF8FAFC),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _Block(width: 90, height: 11),
                      SizedBox(height: 7),
                      _Block(width: 150, height: 20),
                    ],
                  ),
                ),
                const _Block(width: 44, height: 44, radius: 22),
                const SizedBox(width: 8),
                const _Block(width: 44, height: 44, radius: 22),
              ],
            ),
            const SizedBox(height: 9),
            const _Block(width: 125, height: 11),
            const SizedBox(height: 18),
            const _Block(height: 54, radius: 24),
            const SizedBox(height: 16),
            const AspectRatio(
              aspectRatio: 2.05,
              child: _Block(height: double.infinity, radius: 20),
            ),
            const SizedBox(height: 24),
            const _Block(width: 80, height: 16),
            const SizedBox(height: 12),
            const _CategoryGridSkeleton(),
            const SizedBox(height: 24),
            const _Block(width: 175, height: 16),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) =>
                    const SizedBox(width: 198, child: _BusinessCardSkeleton()),
              ),
            ),
            const SizedBox(height: 24),
            const _Block(width: 130, height: 16),
            const SizedBox(height: 12),
            const _Block(height: 88, radius: 20),
          ],
        ),
      ),
    );
  }
}

class _CategoryGridSkeleton extends StatelessWidget {
  const _CategoryGridSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (rowIndex) {
        return Padding(
          padding: EdgeInsets.only(bottom: rowIndex == 2 ? 0 : 8),
          child: Row(
            children: List.generate(4, (columnIndex) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: columnIndex == 3 ? 0 : 8,
                  ),
                  child: const _CategorySkeleton(),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}

class _CategorySkeleton extends StatelessWidget {
  const _CategorySkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          _Block(width: 38, height: 38, radius: 19),
          SizedBox(height: 8),
          _Block(height: 8, radius: 4),
          SizedBox(height: 4),
          _Block(width: 34, height: 8, radius: 4),
        ],
      ),
    );
  }
}

class _BusinessCardSkeleton extends StatelessWidget {
  const _BusinessCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Block(height: 110, radius: 0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _Block(width: 120, height: 12, radius: 6),
                  SizedBox(height: 7),
                  _Block(width: 90, height: 9, radius: 5),
                  Spacer(),
                  _Block(width: 48, height: 16, radius: 8),
                ],
              ),
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
