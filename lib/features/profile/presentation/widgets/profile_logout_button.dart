import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_spacing.dart';

class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.error,
          backgroundColor: isDark
              ? colorScheme.errorContainer.withValues(alpha: 0.18)
              : colorScheme.surface,
          side: BorderSide(color: colorScheme.error.withValues(alpha: 0.4)),
        ),
        icon: const Icon(Icons.logout_rounded, size: 20),
        label: Text(context.l10n.profileLogout),
      ),
    );
  }
}
