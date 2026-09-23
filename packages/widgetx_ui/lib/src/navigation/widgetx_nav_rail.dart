import 'package:flutter/material.dart';

/// A single item in a [WidgetXNavRail].
class WidgetXNavRailItem {
  const WidgetXNavRailItem({
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

/// A WidgetX-styled navigation rail for tablet / desktop layouts.
///
/// Example:
/// ```dart
/// WidgetXNavRail(
///   items: [
///     WidgetXNavRailItem(icon: Icons.home, label: 'Home'),
///     WidgetXNavRailItem(icon: Icons.settings, label: 'Settings'),
///   ],
///   selectedIndex: _index,
///   onDestinationSelected: (i) => setState(() => _index = i),
/// )
/// ```
class WidgetXNavRail extends StatelessWidget {
  /// Creates a [WidgetXNavRail].
  const WidgetXNavRail({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.leading,
    this.trailing,
    this.extended = false,
  });

  final List<WidgetXNavRailItem> items;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  /// Widget above the destinations — typically a logo or FAB.
  final Widget? leading;

  /// Widget below the destinations.
  final Widget? trailing;

  /// Whether to show labels inline (extended rail).
  final bool extended;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      extended: extended,
      leading: leading,
      trailing: trailing,
      destinations: items
          .map(
            (item) => NavigationRailDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.activeIcon ?? item.icon),
              label: Text(item.label),
            ),
          )
          .toList(),
    );
  }
}
