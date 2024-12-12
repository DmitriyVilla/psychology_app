import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  final int selectedIndex;
  final Widget mainArea;
  final ValueChanged<int> onDestinationSelected;

  const MobileLayout({
    super.key,
    required this.selectedIndex,
    required this.mainArea,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Expanded(child: mainArea),
        SafeArea(
          child: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home, color: colorScheme.onPrimary),
                label: 'Home',
              ),
              NavigationDestination(
                icon: const Icon(Icons.search_outlined),
                selectedIcon: Icon(Icons.search,color: colorScheme.onPrimary),
                label: 'Search',
              ),
              NavigationDestination(
                icon: const Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite,color: colorScheme.onPrimary),
                label: 'Favorites',
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings,color: colorScheme.onPrimary),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ],
    );
  }
}