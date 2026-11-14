import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class AppAssetImage extends StatelessWidget {
  const AppAssetImage({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.fallbackIcon = Icons.storefront_rounded,
    this.semanticLabel,
    this.placeholder,
  });

  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final IconData fallbackIcon;
  final String? semanticLabel;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        assetPath,
        width: width,
        height: height,
        fit: fit,
        semanticLabel: semanticLabel,
        gaplessPlayback: true,
        frameBuilder: placeholder == null
            ? null
            : (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded || frame != null) {
                  return child;
                }
                return placeholder!;
              },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: AppColors.tealSoft,
            alignment: Alignment.center,
            child: Icon(fallbackIcon, color: colorScheme.primary, size: 34),
          );
        },
      ),
    );
  }
}
