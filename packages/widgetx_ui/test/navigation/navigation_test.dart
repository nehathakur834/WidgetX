import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: WidgetXTheme.light(),
      home: Scaffold(body: child),
    );

void main() {
  group('WidgetXAppBar', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: WidgetXTheme.light(),
        home: const Scaffold(appBar: WidgetXAppBar(title: 'Settings')),
      ));
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('renders subtitle when provided', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: WidgetXTheme.light(),
        home: const Scaffold(
          appBar: WidgetXAppBar(title: 'Home', subtitle: 'Dashboard'),
        ),
      ));
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('has correct preferredSize', (tester) async {
      const appBar = WidgetXAppBar(title: 'Test');
      expect(appBar.preferredSize.height, kToolbarHeight);
    });
  });

  group('WidgetXBottomNav', () {
    testWidgets('renders destination labels', (tester) async {
      await tester.pumpWidget(_wrap(
        WidgetXBottomNav(
          items: const [
            WidgetXNavItem(icon: Icons.home, label: 'Home'),
            WidgetXNavItem(icon: Icons.person, label: 'Profile'),
          ],
          selectedIndex: 0,
          onDestinationSelected: (_) {},
        ),
      ));
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('calls onDestinationSelected when tapped', (tester) async {
      int selected = -1;
      await tester.pumpWidget(_wrap(
        WidgetXBottomNav(
          items: const [
            WidgetXNavItem(icon: Icons.home, label: 'Home'),
            WidgetXNavItem(icon: Icons.person, label: 'Profile'),
          ],
          selectedIndex: 0,
          onDestinationSelected: (i) => selected = i,
        ),
      ));
      await tester.tap(find.text('Profile'));
      expect(selected, 1);
    });
  });

  group('WidgetXTabBar', () {
    testWidgets('renders tab labels', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: WidgetXTheme.light(),
        home: const Scaffold(
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                WidgetXTabBar(tabs: ['Tab A', 'Tab B']),
              ],
            ),
          ),
        ),
      ));
      expect(find.text('Tab A'), findsOneWidget);
      expect(find.text('Tab B'), findsOneWidget);
    });
  });

  group('WidgetXNavRail', () {
    testWidgets('renders destination labels', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: WidgetXTheme.light(),
        home: Scaffold(
          body: Row(
            children: [
              WidgetXNavRail(
                items: const [
                  WidgetXNavRailItem(icon: Icons.dashboard, label: 'Dashboard'),
                  WidgetXNavRailItem(icon: Icons.settings, label: 'Settings'),
                ],
                selectedIndex: 0,
                onDestinationSelected: (_) {},
              ),
            ],
          ),
        ),
      ));
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });
  });

  group('WidgetXBreadcrumbs', () {
    testWidgets('renders all breadcrumb labels', (tester) async {
      await tester.pumpWidget(_wrap(
        WidgetXBreadcrumbs(
          items: [
            WidgetXBreadcrumbItem(label: 'Home', onTap: () {}),
            WidgetXBreadcrumbItem(label: 'Products', onTap: () {}),
            const WidgetXBreadcrumbItem(label: 'Details'),
          ],
        ),
      ));
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Products'), findsOneWidget);
      expect(find.text('Details'), findsOneWidget);
    });
  });

  group('WidgetXSegmentedControl', () {
    testWidgets('renders all segment labels', (tester) async {
      await tester.pumpWidget(_wrap(
        WidgetXSegmentedControl(
          segments: const ['Day', 'Week', 'Month'],
          selectedIndex: 0,
          onChanged: (_) {},
        ),
      ));
      expect(find.text('Day'), findsOneWidget);
      expect(find.text('Week'), findsOneWidget);
      expect(find.text('Month'), findsOneWidget);
    });

    testWidgets('calls onChanged when a segment is tapped', (tester) async {
      int selected = -1;
      await tester.pumpWidget(_wrap(
        WidgetXSegmentedControl(
          segments: const ['A', 'B'],
          selectedIndex: 0,
          onChanged: (i) => selected = i,
        ),
      ));
      await tester.tap(find.text('B'));
      expect(selected, 1);
    });
  });
}
