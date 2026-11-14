import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_spacing.dart';

class ProfileEmergencyCard extends StatelessWidget {
  const ProfileEmergencyCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Material(
        color: isDark
            ? colorScheme.errorContainer.withValues(alpha: 0.35)
            : colorScheme.errorContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
          side: BorderSide(
            color: colorScheme.error.withValues(alpha: isDark ? 0.35 : 0.18),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.error.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.emergency_rounded,
                    size: 23,
                    color: colorScheme.error,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.profileEmergencyTitle,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: colorScheme.onErrorContainer,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        context.l10n.profileEmergencySubtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onErrorContainer.withValues(
                            alpha: 0.78,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isRtl
                      ? Icons.chevron_left_rounded
                      : Icons.chevron_right_rounded,
                  size: 20,
                  color: colorScheme.onErrorContainer,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
