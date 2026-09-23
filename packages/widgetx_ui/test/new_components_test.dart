import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: WidgetXTheme.light(),
      home: Scaffold(body: child),
    );

void main() {
  // ── WidgetXFAB ────────────────────────────────────────────────────────────
  group('WidgetXFAB', () {
    testWidgets('renders with icon', (tester) async {
      await tester.pumpWidget(
        _wrap(WidgetXFAB(icon: Icons.add, onPressed: () {})),
      );
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('renders extended FAB with label', (tester) async {
      await tester.pumpWidget(
        _wrap(WidgetXFAB(icon: Icons.edit, label: 'Create', onPressed: () {})),
      );
      expect(find.text('Create'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(WidgetXFAB(icon: Icons.add, onPressed: () => tapped = true)),
      );
      await tester.tap(find.byType(FloatingActionButton).first);
      expect(tapped, isTrue);
    });
  });

  // ── WidgetXToggleButtonGroup ──────────────────────────────────────────────
  group('WidgetXToggleButtonGroup', () {
    testWidgets('renders all toggle items', (tester) async {
      await tester.pumpWidget(
        _wrap(
          WidgetXToggleButtonGroup(
            items: const [
              WidgetXToggleItem(label: 'A'),
              WidgetXToggleItem(label: 'B'),
              WidgetXToggleItem(label: 'C'),
            ],
            selectedIndices: const {0},
            onChanged: (_) {},
          ),
        ),
      );
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
    });

    testWidgets('calls onChanged with correct index', (tester) async {
      Set<int>? received;
      await tester.pumpWidget(
        _wrap(
          WidgetXToggleButtonGroup(
            items: const [
              WidgetXToggleItem(label: 'X'),
              WidgetXToggleItem(label: 'Y'),
            ],
            selectedIndices: const {0},
            onChanged: (s) => received = s,
          ),
        ),
      );
      await tester.tap(find.text('Y'));
      expect(received, contains(1));
    });
  });

  // ── WidgetXOTPField ───────────────────────────────────────────────────────
  group('WidgetXOTPField', () {
    testWidgets('renders correct number of boxes', (tester) async {
      await tester.pumpWidget(_wrap(const WidgetXOTPField(length: 4)));
      // Each box is a TextField
      expect(find.byType(TextField), findsNWidgets(4));
    });

    testWidgets('renders 6 boxes by default', (tester) async {
      await tester.pumpWidget(_wrap(const WidgetXOTPField()));
      expect(find.byType(TextField), findsNWidgets(6));
    });
  });

  // ── WidgetXPagination ────────────────────────────────────────────────────
  group('WidgetXPagination', () {
    testWidgets('renders page 1 of 5', (tester) async {
      await tester.pumpWidget(
        _wrap(
          WidgetXPagination(
            currentPage: 1,
            totalPages: 5,
            onPageChanged: (_) {},
          ),
        ),
      );
      expect(find.text('1'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('calls onPageChanged when next is tapped', (tester) async {
      int? changed;
      await tester.pumpWidget(
        _wrap(
          WidgetXPagination(
            currentPage: 1,
            totalPages: 5,
            onPageChanged: (p) => changed = p,
          ),
        ),
      );
      await tester.tap(find.byIcon(Icons.chevron_right));
      expect(changed, 2);
    });

    testWidgets('prev button disabled on first page', (tester) async {
      await tester.pumpWidget(
        _wrap(
          WidgetXPagination(
            currentPage: 1,
            totalPages: 5,
            onPageChanged: (_) {},
          ),
        ),
      );
      final prevBtn = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.chevron_left),
      );
      expect(prevBtn.onPressed, isNull);
    });
  });

  // ── WidgetXRadioGroup ─────────────────────────────────────────────────────
  group('WidgetXRadioGroup', () {
    testWidgets('renders all radio options', (tester) async {
      await tester.pumpWidget(
        _wrap(
          WidgetXRadioGroup<String>(
            groupValue: 'a',
            onChanged: (_) {},
            children: const [
              WidgetXRadio<String>(label: 'Option A', value: 'a'),
              WidgetXRadio<String>(label: 'Option B', value: 'b'),
            ],
          ),
        ),
      );
      expect(find.text('Option A'), findsOneWidget);
      expect(find.text('Option B'), findsOneWidget);
    });

    testWidgets('calls onChanged when option is tapped', (tester) async {
      String? selected;
      await tester.pumpWidget(
        _wrap(
          WidgetXRadioGroup<String>(
            groupValue: 'a',
            onChanged: (v) => selected = v,
            children: const [
              WidgetXRadio<String>(label: 'Option A', value: 'a'),
              WidgetXRadio<String>(label: 'Option B', value: 'b'),
            ],
          ),
        ),
      );
      await tester.tap(find.text('Option B'));
      expect(selected, 'b');
    });
  });

  // ── WidgetXMultiSelectDropdown ────────────────────────────────────────────
  group('WidgetXMultiSelectDropdown', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(
        _wrap(
          WidgetXMultiSelectDropdown<String>(
            label: 'Skills',
            items: const ['Flutter', 'Dart'],
            itemLabel: (v) => v,
            selectedValues: const [],
            onChanged: (_) {},
          ),
        ),
      );
      expect(find.text('Skills'), findsOneWidget);
    });

    testWidgets('shows hint text when nothing selected', (tester) async {
      await tester.pumpWidget(
        _wrap(
          WidgetXMultiSelectDropdown<String>(
            hint: 'Pick options',
            items: const ['A', 'B'],
            itemLabel: (v) => v,
            selectedValues: const [],
            onChanged: (_) {},
          ),
        ),
      );
      expect(find.text('Pick options'), findsOneWidget);
    });
  });

  // ── Charts ────────────────────────────────────────────────────────────────
  group('WidgetXBarChart', () {
    testWidgets('renders with data', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const WidgetXBarChart(
            data: [
              WidgetXChartPoint(label: 'Jan', value: 50),
              WidgetXChartPoint(label: 'Feb', value: 80),
            ],
            title: 'Revenue',
            height: 200,
          ),
        ),
      );
      expect(find.text('Revenue'), findsOneWidget);
    });

    testWidgets('shows empty message when data is empty', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const WidgetXBarChart(
            data: [],
            height: 100,
            emptyMessage: 'Nothing to show',
          ),
        ),
      );
      expect(find.text('Nothing to show'), findsOneWidget);
    });

    testWidgets('shows loading indicator when isLoading', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const WidgetXBarChart(
            data: [],
            height: 100,
            isLoading: true,
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('WidgetXProgressChart', () {
    testWidgets('shows percentage text', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const WidgetXProgressChart(value: 0.75, label: 'Done'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('75%'), findsOneWidget);
      expect(find.text('Done'), findsOneWidget);
    });
  });

  group('WidgetXPieChart', () {
    testWidgets('renders legend labels', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const WidgetXPieChart(
            segments: [
              WidgetXChartPoint(label: 'Food', value: 40),
              WidgetXChartPoint(label: 'Travel', value: 60),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Food'), findsOneWidget);
      expect(find.text('Travel'), findsOneWidget);
    });
  });
}
