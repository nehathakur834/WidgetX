import 'package:flutter/material.dart';

/// A WidgetX-styled bottom navigation bar item.
class WidgetXNavItem {
  const WidgetXNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.semanticLabel,
  });

  final IconData icon;
  final String label;
  final IconData? activeIcon;
  final String? semanticLabel;
}

/// A WidgetX-styled bottom navigation bar.
///
/// Example:
/// ```dart
/// WidgetXBottomNav(
///   items: [
///     WidgetXNavItem(icon: Icons.home, label: 'Home'),
///     WidgetXNavItem(icon: Icons.person, label: 'Profile'),
///   ],
///   selectedIndex: _index,
///   onDestinationSelected: (i) => setState(() => _index = i),
/// )
/// ```
class WidgetXBottomNav extends StatelessWidget {
  const WidgetXBottomNav({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final List<WidgetXNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: items
          .map(
            (item) => NavigationDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.activeIcon ?? item.icon),
              label: item.label,
              tooltip: item.semanticLabel ?? item.label,
            ),
          )
          .toList(),
    );
  }
}
