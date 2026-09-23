import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

void main() {
  group('WidgetXDialog', () {
    testWidgets('renders title and body', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: WidgetXTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) => WidgetXButton(
                label: 'Open',
                onPressed: () {
                  const WidgetXDialog(
                    title: 'My Dialog',
                    body: Text('Dialog body'),
                  ).show(context);
                },
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('My Dialog'), findsOneWidget);
      expect(find.text('Dialog body'), findsOneWidget);
    });
  });

  group('showWidgetXAlertDialog', () {
    testWidgets('shows dialog with confirm button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: WidgetXTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) => WidgetXButton(
                label: 'Alert',
                onPressed: () => showWidgetXAlertDialog(
                  context: context,
                  title: 'Warning',
                  message: 'This is a warning.',
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Alert'));
      await tester.pumpAndSettle();
      expect(find.text('Warning'), findsOneWidget);
      expect(find.text('This is a warning.'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('dismisses on confirm tap', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: WidgetXTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) => WidgetXButton(
                label: 'Open',
                onPressed: () => showWidgetXAlertDialog(
                  context: context,
                  title: 'Done',
                  message: 'All good.',
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(find.text('Done'), findsNothing);
    });
  });

  group('showWidgetXConfirmDialog', () {
    testWidgets('returns true on confirm', (tester) async {
      bool? result;
      await tester.pumpWidget(
        MaterialApp(
          theme: WidgetXTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) => WidgetXButton(
                label: 'Confirm',
                onPressed: () async {
                  result = await showWidgetXConfirmDialog(
                    context: context,
                    title: 'Delete',
                    message: 'Sure?',
                    confirmLabel: 'Yes',
                    cancelLabel: 'No',
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();
      expect(result, isTrue);
    });

    testWidgets('returns false on cancel', (tester) async {
      bool? result;
      await tester.pumpWidget(
        MaterialApp(
          theme: WidgetXTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) => WidgetXButton(
                label: 'Confirm',
                onPressed: () async {
                  result = await showWidgetXConfirmDialog(
                    context: context,
                    title: 'Delete',
                    message: 'Sure?',
                    confirmLabel: 'Yes',
                    cancelLabel: 'No',
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('No'));
      await tester.pumpAndSettle();
      expect(result, isFalse);
    });
  });
}
