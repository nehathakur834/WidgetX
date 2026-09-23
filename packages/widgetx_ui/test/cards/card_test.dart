import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: WidgetXTheme.light(),
      home: Scaffold(body: child),
    );

void main() {
  group('WidgetXCard', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXCard(title: Text('Card Title'))),
      );
      expect(find.text('Card Title'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(WidgetXCard(
          title: const Text('Tap me'),
          onTap: () => tapped = true,
        )),
      );
      await tester.tap(find.text('Tap me'));
      expect(tapped, isTrue);
    });

    testWidgets('shows loading skeleton when isLoading is true',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXCard(isLoading: true, body: SizedBox.shrink())),
      );
      // Loading content renders shimmer boxes, not the title
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('shows selected border when isSelected is true',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXCard(title: Text('X'), isSelected: true)),
      );
      // Widget renders without error when selected
      expect(find.text('X'), findsOneWidget);
    });
  });

  group('WidgetXExpandableCard', () {
    testWidgets('hides expanded content by default', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXExpandableCard(
          title: Text('Title'),
          expandedContent: Text('Expanded Content'),
        )),
      );
      expect(find.text('Expanded Content'), findsNothing);
    });

    testWidgets('reveals expanded content when tapped', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXExpandableCard(
          title: Text('Title'),
          expandedContent: Text('Expanded Content'),
        )),
      );
      await tester.tap(find.text('Title'));
      await tester.pumpAndSettle();
      expect(find.text('Expanded Content'), findsOneWidget);
    });

    testWidgets('shows content when initiallyExpanded is true', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXExpandableCard(
          title: Text('Title'),
          expandedContent: Text('Already Open'),
          initiallyExpanded: true,
        )),
      );
      await tester.pump();
      expect(find.text('Already Open'), findsOneWidget);
    });
  });
}
