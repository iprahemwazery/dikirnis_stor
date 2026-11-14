import 'package:flutter/material.dart';

import '../../../../theme/app_spacing.dart';
import '../../domain/entities/business.dart';
import 'business_card.dart';

class BusinessHorizontalList extends StatelessWidget {
  const BusinessHorizontalList({
    super.key,
    required this.businesses,
    required this.height,
    required this.cardWidth,
    required this.imageHeight,
    required this.onBusinessTap,
    this.showDescription = false,
    this.showViews = false,
  });

  final List<Business> businesses;
  final double height;
  final double cardWidth;
  final double imageHeight;
  final ValueChanged<Business> onBusinessTap;
  final bool showDescription;
  final bool showViews;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: businesses.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          final business = businesses[index];
          return SizedBox(
            width: cardWidth,
            child: BusinessCard(
              business: business,
              imageHeight: imageHeight,
              showDescription: showDescription,
              showViews: showViews,
              onTap: () => onBusinessTap(business),
            ),
          );
        },
      ),
    );
  }
}
