import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/home/presentation/widgets/home_bottom_navigation_bar.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _selectDestination(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  Future<bool> _handleBackButton() async {
    if (navigationShell.currentIndex == 0) {
      return false;
    }

    _selectDestination(0);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: _handleBackButton,
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: HomeBottomNavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _selectDestination,
        ),
      ),
    );
  }
}
