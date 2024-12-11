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
    return Row(
      children: [
        SafeArea(
          child: NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search_outlined),
                selectedIcon: Icon(Icons.search),
                label: Text('Search'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: Text('Favorites'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('Settings'),
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