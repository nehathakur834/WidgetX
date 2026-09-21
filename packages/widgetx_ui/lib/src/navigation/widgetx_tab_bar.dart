import 'package:flutter/material.dart';

/// A WidgetX-styled tab bar.
///
/// Use within a [DefaultTabController] or supply your own [TabController].
///
/// Example:
/// ```dart
/// DefaultTabController(
///   length: 3,
///   child: Column(
///     children: [
///       WidgetXTabBar(tabs: ['Tab 1', 'Tab 2', 'Tab 3']),
///       Expanded(child: TabBarView(children: [...])),
///     ],
///   ),
/// )
/// ```
class WidgetXTabBar extends StatelessWidget implements PreferredSizeWidget {
  const WidgetXTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.onTap,
  });

  final List<String> tabs;
  final TabController? controller;
  final bool isScrollable;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: isScrollable,
      onTap: onTap,
      tabs: tabs.map((label) => Tab(text: label)).toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}
