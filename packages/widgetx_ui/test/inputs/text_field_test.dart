import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: WidgetXTheme.light(),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );

void main() {
  group('WidgetXTextField', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(_wrap(const WidgetXTextField(label: 'Email')));
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('calls onChanged when text is typed', (tester) async {
      String? changed;
      await tester.pumpWidget(_wrap(
        WidgetXTextField(onChanged: (v) => changed = v),
      ));
      await tester.enterText(find.byType(TextFormField), 'hello');
      expect(changed, 'hello');
    });

    testWidgets('shows error text', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXTextField(errorText: 'Required')),
      );
      expect(find.text('Required'), findsOneWidget);
    });

    testWidgets('disabled field does not accept input', (tester) async {
      final ctrl = TextEditingController();
      await tester.pumpWidget(
        _wrap(WidgetXTextField(controller: ctrl, isEnabled: false)),
      );
      await tester.tap(find.byType(TextFormField));
      await tester.enterText(find.byType(TextFormField), 'blocked');
      expect(ctrl.text, isEmpty);
    });
  });

  group('WidgetXPasswordField', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXPasswordField(label: 'Password')),
      );
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('has visibility toggle button', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXPasswordField(label: 'Password')),
      );
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('toggles visibility on icon tap', (tester) async {
      await tester.pumpWidget(
        _wrap(const WidgetXPasswordField(label: 'Password')),
      );
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });
  });
}
