import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

void main() {
  group('widgetXScreenSizeOf', () {
    test('returns mobile for width < 600', () {
      expect(widgetXScreenSizeOf(0), WidgetXScreenSize.mobile);
      expect(widgetXScreenSizeOf(599), WidgetXScreenSize.mobile);
    });

    test('returns tablet for 600 <= width < 1024', () {
      expect(widgetXScreenSizeOf(600), WidgetXScreenSize.tablet);
      expect(widgetXScreenSizeOf(1023), WidgetXScreenSize.tablet);
    });

    test('returns desktop for 1024 <= width < 1440', () {
      expect(widgetXScreenSizeOf(1024), WidgetXScreenSize.desktop);
      expect(widgetXScreenSizeOf(1439), WidgetXScreenSize.desktop);
    });

    test('returns widescreen for width >= 1440', () {
      expect(widgetXScreenSizeOf(1440), WidgetXScreenSize.widescreen);
      expect(widgetXScreenSizeOf(2560), WidgetXScreenSize.widescreen);
    });

    test('respects custom config', () {
      const config = WidgetXBreakpointConfig(tablet: 500, desktop: 900);
      expect(
          widgetXScreenSizeOf(499, config: config), WidgetXScreenSize.mobile);
      expect(
          widgetXScreenSizeOf(500, config: config), WidgetXScreenSize.tablet);
      expect(
          widgetXScreenSizeOf(900, config: config), WidgetXScreenSize.desktop);
    });
  });

  group('WidgetXResponsive', () {
    testWidgets('shows mobile widget at narrow width', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        const MaterialApp(
          home: WidgetXResponsive(
            mobile: Text('Mobile'),
            tablet: Text('Tablet'),
            desktop: Text('Desktop'),
          ),
        ),
      );
      expect(find.text('Mobile'), findsOneWidget);
      expect(find.text('Tablet'), findsNothing);
    });

    testWidgets('shows desktop widget at wide width', (tester) async {
      tester.view.physicalSize = const Size(1200, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        const MaterialApp(
          home: WidgetXResponsive(
            mobile: Text('Mobile'),
            tablet: Text('Tablet'),
            desktop: Text('Desktop'),
          ),
        ),
      );
      expect(find.text('Desktop'), findsOneWidget);
      expect(find.text('Mobile'), findsNothing);
    });

    testWidgets('falls back to mobile when tablet is not provided',
        (tester) async {
      tester.view.physicalSize = const Size(700, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        const MaterialApp(
          home: WidgetXResponsive(mobile: Text('Mobile')),
        ),
      );
      expect(find.text('Mobile'), findsOneWidget);
    });
  });
}
