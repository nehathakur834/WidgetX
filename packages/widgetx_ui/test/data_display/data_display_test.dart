import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: WidgetXTheme.light(),
      home: Scaffold(body: child),
    );

void main() {
  group('WidgetXBadge', () {
    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(_wrap(
        const WidgetXBadge(label: '3', variant: WidgetXBadgeVariant.error),
      ));
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('renders all variants without error', (tester) async {
      for (final v in WidgetXBadgeVariant.values) {
        await tester.pumpWidget(_wrap(WidgetXBadge(label: v.name, variant: v)));
        expect(find.text(v.name), findsOneWidget);
      }
    });

    testWidgets('has Semantics label', (tester) async {
      await tester.pumpWidget(_wrap(
        const WidgetXBadge(label: '5', semanticLabel: 'Five notifications'),
      ));
      final label = tester.getSemantics(find.byType(WidgetXBadge)).label;
      expect(label, contains('Five notifications'));
    });
  });

  group('WidgetXAvatar', () {
    testWidgets('renders initials', (tester) async {
      await tester.pumpWidget(_wrap(const WidgetXAvatar(initials: 'JD')));
      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('renders icon', (tester) async {
      await tester.pumpWidget(_wrap(const WidgetXAvatar(icon: Icons.person)));
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(WidgetXAvatar(
        initials: 'AB',
        onTap: () => tapped = true,
      )));
      await tester.tap(find.byType(WidgetXAvatar));
      expect(tapped, isTrue);
    });

    testWidgets('xl size diameter is 80', (tester) async {
      await tester.pumpWidget(_wrap(
        const WidgetXAvatar(initials: 'AB', size: WidgetXAvatarSize.xl),
      ));
      final circle = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(circle.radius, 40);
    });
  });

  group('WidgetXTimeline', () {
    testWidgets('renders all item titles', (tester) async {
      await tester.pumpWidget(_wrap(
        const WidgetXTimeline(
          items: [
            WidgetXTimelineItem(title: 'Step one', isCompleted: true),
            WidgetXTimelineItem(title: 'Step two', isActive: true),
            WidgetXTimelineItem(title: 'Step three'),
          ],
        ),
      ));
      expect(find.text('Step one'), findsOneWidget);
      expect(find.text('Step two'), findsOneWidget);
      expect(find.text('Step three'), findsOneWidget);
    });

    testWidgets('renders subtitle when provided', (tester) async {
      await tester.pumpWidget(_wrap(
        const WidgetXTimeline(
          items: [
            WidgetXTimelineItem(
              title: 'Event',
              subtitle: 'Extra detail',
              time: '10:00',
            ),
          ],
        ),
      ));
      expect(find.text('Extra detail'), findsOneWidget);
      expect(find.text('10:00'), findsOneWidget);
    });
  });

  group('WidgetXAccordion', () {
    testWidgets('hides content by default', (tester) async {
      await tester.pumpWidget(_wrap(
        const WidgetXAccordion(
          items: [
            WidgetXAccordionItem(title: 'FAQ', content: Text('Answer here')),
          ],
        ),
      ));
      expect(find.text('Answer here'), findsNothing);
    });

    testWidgets('shows content after tap', (tester) async {
      await tester.pumpWidget(_wrap(
        const WidgetXAccordion(
          items: [
            WidgetXAccordionItem(title: 'FAQ', content: Text('Answer here')),
          ],
        ),
      ));
      await tester.tap(find.text('FAQ'));
      await tester.pumpAndSettle();
      expect(find.text('Answer here'), findsOneWidget);
    });

    testWidgets('collapses sibling when allowMultiple is false',
        (tester) async {
      await tester.pumpWidget(_wrap(
        const WidgetXAccordion(
          allowMultiple: false,
          items: [
            WidgetXAccordionItem(title: 'Q1', content: Text('A1')),
            WidgetXAccordionItem(title: 'Q2', content: Text('A2')),
          ],
        ),
      ));
      await tester.tap(find.text('Q1'));
      await tester.pumpAndSettle();
      expect(find.text('A1'), findsOneWidget);

      await tester.tap(find.text('Q2'));
      await tester.pumpAndSettle();
      expect(find.text('A2'), findsOneWidget);
      expect(find.text('A1'), findsNothing);
    });
  });

  group('WidgetXDataTable', () {
    testWidgets('renders column headers', (tester) async {
      await tester.pumpWidget(_wrap(
        const WidgetXDataTable(
          columns: ['Name', 'Role'],
          rows: [
            ['Alice', 'Designer'],
          ],
        ),
      ));
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Role'), findsOneWidget);
    });

    testWidgets('renders row data', (tester) async {
      await tester.pumpWidget(_wrap(
        const WidgetXDataTable(
          columns: ['Name', 'Role'],
          rows: [
            ['Alice', 'Designer'],
            ['Bob', 'Engineer'],
          ],
        ),
      ));
      expect(find.text('Alice'), findsOneWidget);
      expect(find.text('Bob'), findsOneWidget);
    });

    testWidgets('shows empty message when rows is empty', (tester) async {
      await tester.pumpWidget(_wrap(
        const WidgetXDataTable(
          columns: ['Name'],
          rows: [],
          emptyMessage: 'No records',
        ),
      ));
      expect(find.text('No records'), findsOneWidget);
    });

    testWidgets('shows loading state', (tester) async {
      await tester.pumpWidget(_wrap(
        const WidgetXDataTable(
          columns: ['Name'],
          rows: [
            ['Alice'],
          ],
          isLoading: true,
        ),
      ));
      // Loading renders containers instead of data
      expect(find.text('Alice'), findsNothing);
    });
  });

  group('WidgetXEmptyState', () {
    testWidgets('renders title and description', (tester) async {
      await tester.pumpWidget(_wrap(
        const WidgetXEmptyState(
          title: 'Nothing here',
          description: 'Add some items.',
          icon: Icons.inbox_outlined,
        ),
      ));
      expect(find.text('Nothing here'), findsOneWidget);
      expect(find.text('Add some items.'), findsOneWidget);
    });

    testWidgets('uses error icon when isError is true', (tester) async {
      await tester.pumpWidget(_wrap(
        const WidgetXEmptyState(
          isError: true,
          title: 'Error occurred',
        ),
      ));
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });

  group('WidgetXListTile', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(_wrap(
        const WidgetXListTile(title: 'Alice Chen'),
      ));
      expect(find.text('Alice Chen'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(WidgetXListTile(
        title: 'Tap me',
        onTap: () => tapped = true,
      )));
      await tester.tap(find.byType(ListTile));
      expect(tapped, isTrue);
    });

    testWidgets('does not call onTap when disabled', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(WidgetXListTile(
        title: 'Disabled',
        isEnabled: false,
        onTap: () => tapped = true,
      )));
      await tester.tap(find.byType(ListTile));
      expect(tapped, isFalse);
    });
  });
}
