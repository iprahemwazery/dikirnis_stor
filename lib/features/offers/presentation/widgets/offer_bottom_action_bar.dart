import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_shadows.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/offer.dart';

class OfferBottomActionBar extends StatelessWidget {
  const OfferBottomActionBar({
    super.key,
    required this.offer,
    required this.onCall,
    required this.onWhatsApp,
    required this.onOrder,
  });

  final Offer offer;
  final VoidCallback onCall;
  final VoidCallback onWhatsApp;
  final VoidCallback onOrder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.homeBorder,
          ),
        ),
        boxShadow: isDark ? const [] : AppShadows.navigation,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.sm,
          ),
          child: Row(
            children: [
              _ContactButton(
                tooltip: context.l10n.offerContactCall,
                icon: Icons.call_outlined,
                onTap: onCall,
              ),
              const SizedBox(width: AppSpacing.xs),
              _ContactButton(
                tooltip: context.l10n.offerContactWhatsapp,
                icon: Icons.chat_bubble_outline_rounded,
                onTap: onWhatsApp,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: FilledButton.icon(
                  key: const ValueKey('offer_order_now'),
                  onPressed: offer.isAvailable ? onOrder : null,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.lg),
                    ),
                  ),
                  icon: const Icon(Icons.shopping_bag_outlined, size: 20),
                  label: Text(
                    offer.isAvailable
                        ? context.l10n.offerOrderNow
                        : context.l10n.offerDetailsUnavailable,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: offer.isAvailable
                          ? colorScheme.onPrimary
                          : colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactButton extends StatelessWidget {
  const _ContactButton({
    required this.tooltip,
    required this.icon,
    required this.onTap,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox.square(
            dimension: 52,
            child: Icon(icon, color: colorScheme.primary, size: 22),
          ),
        ),
      ),
    );
  }
}
