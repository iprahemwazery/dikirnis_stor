import 'package:flutter/material.dart';

import '../../../../theme/app_radii.dart';
import '../../../../theme/app_spacing.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
    this.topPadding = AppSpacing.lg,
    this.showAccent = false,
    this.titleColor,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final double topPadding;
  final bool showAccent;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        topPadding,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          if (showAccent) ...[
            Container(
              width: 4,
              height: 18,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium?.copyWith(
                color: titleColor ?? colorScheme.onSurface,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          if (actionLabel != null && onAction != null)
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.primary,
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: 4,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    actionLabel!,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    isRtl
                        ? Icons.chevron_left_rounded
                        : Icons.chevron_right_rounded,
                    size: 17,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
