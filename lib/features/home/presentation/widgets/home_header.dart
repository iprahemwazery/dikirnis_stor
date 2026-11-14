import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_spacing.dart';
import 'home_action_button.dart';
import 'home_search_bar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.userName,
    required this.userLocation,
    required this.onSearchSubmitted,
    required this.onNotificationsTap,
    required this.onMessagesTap,
  });

  final String userName;
  final String userLocation;
  final ValueChanged<String> onSearchSubmitted;
  final VoidCallback onNotificationsTap;
  final VoidCallback onMessagesTap;

  String _greeting(BuildContext context) {
    final hour = DateTime.now().hour;
    return hour >= 5 && hour < 17
        ? context.l10n.goodMorning
        : context.l10n.goodEvening;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _greeting(context),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              HomeActionButton(
                icon: Icons.chat_bubble_outline_rounded,
                tooltip: context.l10n.messagesLabel,
                onTap: onMessagesTap,
              ),
              const SizedBox(width: AppSpacing.sm),
              HomeActionButton(
                icon: Icons.notifications_none_rounded,
                tooltip: context.l10n.notificationsLabel,
                onTap: onNotificationsTap,
                badgeCount: 3,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 16,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  userLocation,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 17,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          HomeSearchBar(onSubmitted: onSearchSubmitted),
        ],
      ),
    );
  }
}
