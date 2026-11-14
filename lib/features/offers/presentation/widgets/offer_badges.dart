import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';

class OfferDiscountBadge extends StatelessWidget {
  const OfferDiscountBadge({
    super.key,
    required this.percent,
    this.compact = false,
  });

  final int percent;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 7 : 10,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE45757),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        '$percent%',
        textDirection: TextDirection.ltr,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontSize: compact ? 10 : 12,
          fontWeight: FontWeight.w800,
          height: 1,
        ),
      ),
    );
  }
}

class OfferFeaturedBadge extends StatelessWidget {
  const OfferFeaturedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.rating,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.workspace_premium_rounded,
            size: 12,
            color: Colors.white,
          ),
          const SizedBox(width: 3),
          Text(
            context.l10n.offersFeaturedBadge,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
