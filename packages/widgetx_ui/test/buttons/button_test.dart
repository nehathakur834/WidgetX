import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: WidgetXTheme.light(),
      home: Scaffold(body: child),
    );

void main() {
  group('WidgetXButton', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(
        _wrap(WidgetXButton(label: 'Submit', onPressed: () {})),
      );
      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(WidgetXButton(label: 'Tap', onPressed: () => tapped = true)),
      );
      await tester.tap(find.text('Tap'));
      expect(tapped, isTrue);
    });

    testWidgets('disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXButton(label: 'Disabled')),
      );
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('shows loading indicator when isLoading is true',
        (tester) async {
      await tester.pumpWidget(
        _wrap(WidgetXButton(label: 'Load', isLoading: true, onPressed: () {})),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Load'), findsNothing);
    });

    testWidgets('renders outlined variant as OutlinedButton', (tester) async {
      await tester.pumpWidget(
        _wrap(WidgetXButton(
          label: 'Outlined',
          variant: WidgetXButtonVariant.outlined,
          onPressed: () {},
        )),
      );
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('renders text variant as TextButton', (tester) async {
      await tester.pumpWidget(
        _wrap(WidgetXButton(
          label: 'Text',
          variant: WidgetXButtonVariant.text,
          onPressed: () {},
        )),
      );
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('full-width wraps in SizedBox with infinite width',
        (tester) async {
      await tester.pumpWidget(
        _wrap(SizedBox(
          width: 400,
          child:
              WidgetXButton(label: 'Full', isFullWidth: true, onPressed: () {}),
        )),
      );
      final box = tester.widget<SizedBox>(find
          .ancestor(
            of: find.byType(ElevatedButton),
            matching: find.byType(SizedBox),
          )
          .first);
      expect(box.width, double.infinity);
    });

    testWidgets('has Semantics with button role', (tester) async {
      await tester.pumpWidget(
        _wrap(WidgetXButton(
          label: 'Accessible',
          onPressed: () {},
          semanticLabel: 'Custom label',
        )),
      );
      final semantics = tester.getSemantics(find.byType(WidgetXButton));
      expect(semantics.label, 'Custom label');
    });
  });
}
