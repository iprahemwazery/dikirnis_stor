import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import 'app_button.dart';

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    required this.message,
    this.title,
    this.onRetry,
    this.retryLabel,
    this.icon = Icons.cloud_off_rounded,
  });

  final String message;
  final String? title;
  final VoidCallback? onRetry;
  final String? retryLabel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 36,
                  color: colorScheme.onErrorContainer,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (title != null) ...[
                Text(
                  title!,
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xs),
              ],
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              if (onRetry != null && retryLabel != null) ...[
                const SizedBox(height: AppSpacing.lg),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: AppButton(
                    label: retryLabel!,
                    onPressed: onRetry,
                    icon: Icons.refresh_rounded,
                    expand: false,
                    variant: AppButtonVariant.outlined,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
