import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_shadows.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final l10n = context.l10n;
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final height = (70 + (textScale - 1) * 24).clamp(70.0, 108.0);

    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadii.xl),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.homeBorder,
          ),
          boxShadow: isDark ? const [] : AppShadows.navigation,
        ),
        child: Row(
          children: [
            _NavItem(
              icon: Icons.home_rounded,
              label: l10n.navHome,
              isSelected: selectedIndex == 0,
              onTap: () => onDestinationSelected(0),
            ),
            _NavItem(
              icon: Icons.explore_outlined,
              label: l10n.navExplore,
              isSelected: selectedIndex == 1,
              onTap: () => onDestinationSelected(1),
            ),
            Expanded(
              child: Tooltip(
                message: l10n.navMarketplace,
                child: Semantics(
                  button: true,
                  label: l10n.navMarketplace,
                  child: Center(
                    child: Material(
                      color: AppColors.purple,
                      shape: const CircleBorder(),
                      elevation: 4,
                      shadowColor: AppColors.purple.withValues(alpha: 0.4),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => onDestinationSelected(2),
                        child: SizedBox.square(
                          dimension: 52,
                          child: const Icon(
                            Icons.storefront_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _NavItem(
              icon: Icons.local_offer_outlined,
              label: l10n.navOffers,
              isSelected: selectedIndex == 3,
              onTap: () => onDestinationSelected(3),
            ),
            _NavItem(
              icon: Icons.person_outline_rounded,
              label: l10n.navProfile,
              isSelected: selectedIndex == 4,
              onTap: () => onDestinationSelected(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final color = isSelected
        ? colorScheme.primary
        : colorScheme.onSurfaceVariant;

    return Expanded(
      child: Semantics(
        button: true,
        selected: isSelected,
        label: label,
        child: InkWell(
          onTap: onTap,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colorScheme.primary.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppRadii.md),
                  ),
                  child: Icon(icon, size: 22, color: color),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: color,
                    fontSize: 10.5,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    height: 1.15,
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
