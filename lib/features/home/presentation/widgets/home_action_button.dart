import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class HomeActionButton extends StatelessWidget {
  const HomeActionButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.badgeCount = 0,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderColor = theme.brightness == Brightness.dark
        ? AppColors.darkBorder
        : AppColors.homeBorder;
    return Tooltip(
      message: tooltip,
      child: Material(
        color: colorScheme.surface,
        shape: CircleBorder(side: BorderSide(color: borderColor)),
        elevation: 0,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox.square(
            dimension: 44,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Icon(icon, size: 22, color: colorScheme.onSurface),
                ),
                if (badgeCount > 0)
                  PositionedDirectional(
                    top: 3,
                    start: 3,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 17,
                        minHeight: 17,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: const BoxDecoration(
                        color: AppColors.notificationBadge,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        badgeCount > 9 ? '9+' : '$badgeCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
