import 'package:flutter/material.dart';

import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import 'app_button.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.message,
    this.title,
    this.actionLabel,
    this.onAction,
    this.icon = Icons.search_off_rounded,
  });

  final String message;
  final String? title;
  final String? actionLabel;
  final VoidCallback? onAction;
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
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppRadii.xl),
                ),
                child: Icon(
                  icon,
                  size: 36,
                  color: colorScheme.onSurfaceVariant,
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
              if (onAction != null && actionLabel != null) ...[
                const SizedBox(height: AppSpacing.lg),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: AppButton(
                    label: actionLabel!,
                    onPressed: onAction,
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
