import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_shadows.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/offer_seller.dart';

class OfferSellerCard extends StatelessWidget {
  const OfferSellerCard({
    super.key,
    required this.seller,
    required this.headingColor,
    required this.onCall,
    required this.onWhatsApp,
  });

  final OfferSeller seller;
  final Color headingColor;
  final VoidCallback onCall;
  final VoidCallback onWhatsApp;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final initial = seller.name.trim().isEmpty
        ? '?'
        : seller.name.trim().substring(0, 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.offerSellerTitle,
          style: theme.textTheme.titleMedium?.copyWith(
            color: headingColor,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadii.lg),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.homeBorder,
            ),
            boxShadow: isDark ? const [] : AppShadows.card,
          ),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: colorScheme.primary.withValues(
                      alpha: 0.12,
                    ),
                    child: Text(
                      initial,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                seller.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: headingColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            if (seller.isVerified) ...[
                              const SizedBox(width: 4),
                              Icon(
                                Icons.verified_rounded,
                                size: 16,
                                color: colorScheme.primary,
                              ),
                            ],
                          ],
                        ),
                        if (seller.location != null) ...[
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 13,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 3),
                              Expanded(
                                child: Text(
                                  seller.location!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (seller.memberSince != null) ...[
                          const SizedBox(height: 3),
                          Text(
                            context.l10n.offerSellerMemberSince(
                              seller.memberSince!,
                            ),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onCall,
                      icon: const Icon(Icons.call_outlined, size: 18),
                      label: Text(context.l10n.offerContactCall),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onWhatsApp,
                      icon: const Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 18,
                      ),
                      label: Text(context.l10n.offerContactWhatsapp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
