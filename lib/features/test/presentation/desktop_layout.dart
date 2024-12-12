import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  final int selectedIndex;
  final Widget mainArea;
  final ValueChanged<int> onDestinationSelected;
  final bool extended;

  const DesktopLayout({
    super.key,
    required this.selectedIndex,
    required this.mainArea,
    required this.onDestinationSelected,
    required this.extended,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        SafeArea(
          child: NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            destinations: [
              NavigationRailDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home, color: colorScheme.onPrimary),
                label: const Text('Home'),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.search_outlined),
                selectedIcon: Icon(Icons.search, color: colorScheme.onPrimary),
                label: const Text('Search'),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite, color: colorScheme.onPrimary),
                label: const Text('Favorites'),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings, color: colorScheme.onPrimary),
                label: const Text('Settings'),
              ),
            ],
            extended: extended,
          ),
        ),
        Expanded(child: mainArea),
      ],
    );
  }
}