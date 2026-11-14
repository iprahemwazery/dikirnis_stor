import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';

class BusinessBadge extends StatelessWidget {
  const BusinessBadge({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
    this.icon,
  });

  final String label;
  final Color background;
  final Color foreground;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: foreground),
            const SizedBox(width: 3),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: foreground,
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

class NewBusinessBadge extends StatelessWidget {
  const NewBusinessBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BusinessBadge(
      label: context.l10n.newBadge,
      icon: Icons.auto_awesome_rounded,
      background: colorScheme.primary,
      foreground: colorScheme.onPrimary,
    );
  }
}

class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BusinessBadge(
      label: context.l10n.verifiedBadge,
      icon: Icons.verified_rounded,
      background: colorScheme.primary.withValues(alpha: 0.12),
      foreground: colorScheme.primary,
    );
  }
}

class SponsoredBadge extends StatelessWidget {
  const SponsoredBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return BusinessBadge(
      label: context.l10n.sponsoredBadge,
      icon: Icons.bolt_rounded,
      background: AppColors.rating,
      foreground: const Color(0xFF3E2A00),
    );
  }
}
