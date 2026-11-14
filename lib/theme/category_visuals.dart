import 'package:flutter/material.dart';

import 'app_colors.dart';

class CategoryVisual {
  const CategoryVisual({
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final Color background;
  final Color foreground;
}

CategoryVisual categoryVisualFor(String iconKey) {
  return switch (iconKey) {
    'point_of_sale' || 'commercial' => const CategoryVisual(
      icon: Icons.point_of_sale_rounded,
      background: Color(0xFFFFF1E2),
      foreground: Color(0xFFD98324),
    ),
    'restaurant' || 'restaurants' => const CategoryVisual(
      icon: Icons.restaurant_rounded,
      background: Color(0xFFFFEAEA),
      foreground: Color(0xFFE45757),
    ),
    'medical' => const CategoryVisual(
      icon: Icons.medical_services_rounded,
      background: AppColors.tealSoft,
      foreground: AppColors.primary,
    ),
    'work' || 'jobs' => const CategoryVisual(
      icon: Icons.work_outline_rounded,
      background: Color(0xFFEAF1FF),
      foreground: Color(0xFF4D7CFE),
    ),
    'sports' => const CategoryVisual(
      icon: Icons.sports_soccer_rounded,
      background: Color(0xFFEAF8EE),
      foreground: Color(0xFF3D9A57),
    ),
    'home_goods' => const CategoryVisual(
      icon: Icons.shopping_basket_rounded,
      background: Color(0xFFFFF7DE),
      foreground: Color(0xFFC58A13),
    ),
    'services' || 'home_services' => const CategoryVisual(
      icon: Icons.handyman_rounded,
      background: Color(0xFFF1EDFF),
      foreground: Color(0xFF7557D9),
    ),
    'education' => const CategoryVisual(
      icon: Icons.school_rounded,
      background: Color(0xFFEAF0FF),
      foreground: Color(0xFF5369C9),
    ),
    'government' => const CategoryVisual(
      icon: Icons.account_balance_rounded,
      background: Color(0xFFEEF1F5),
      foreground: Color(0xFF5E6B7A),
    ),
    'religion' || 'religion_society' => const CategoryVisual(
      icon: Icons.mosque_rounded,
      background: Color(0xFFE8F6F1),
      foreground: Color(0xFF1C7A65),
    ),
    'transport' => const CategoryVisual(
      icon: Icons.delivery_dining_rounded,
      background: Color(0xFFE9F6FF),
      foreground: Color(0xFF2E86C1),
    ),
    'grocery' => const CategoryVisual(
      icon: Icons.local_grocery_store_rounded,
      background: Color(0xFFEAF8EE),
      foreground: Color(0xFF3D9A57),
    ),
    'pharmacy' => const CategoryVisual(
      icon: Icons.local_pharmacy_rounded,
      background: Color(0xFFE8F6F1),
      foreground: Color(0xFF1C7A65),
    ),
    'electronics' => const CategoryVisual(
      icon: Icons.devices_other_rounded,
      background: Color(0xFFEAF1FF),
      foreground: Color(0xFF4D7CFE),
    ),
    'clothing' => const CategoryVisual(
      icon: Icons.checkroom_rounded,
      background: Color(0xFFF1EDFF),
      foreground: Color(0xFF7557D9),
    ),
    'automotive' => const CategoryVisual(
      icon: Icons.directions_car_filled_rounded,
      background: Color(0xFFEEF1F5),
      foreground: Color(0xFF5E6B7A),
    ),
    'beauty' => const CategoryVisual(
      icon: Icons.spa_rounded,
      background: Color(0xFFFFEAEA),
      foreground: Color(0xFFE45757),
    ),
    _ => const CategoryVisual(
      icon: Icons.grid_view_rounded,
      background: AppColors.tealSoft,
      foreground: AppColors.primary,
    ),
  };
}
