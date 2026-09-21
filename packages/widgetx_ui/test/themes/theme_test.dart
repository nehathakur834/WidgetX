import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

void main() {
  group('WidgetXTheme', () {
    test('light() returns a ThemeData with light brightness', () {
      final theme = WidgetXTheme.light();
      expect(theme.brightness, Brightness.light);
    });

    test('dark() returns a ThemeData with dark brightness', () {
      final theme = WidgetXTheme.dark();
      expect(theme.brightness, Brightness.dark);
    });

    test('light() uses Material 3', () {
      expect(WidgetXTheme.light().useMaterial3, isTrue);
    });

    test('dark() uses Material 3', () {
      expect(WidgetXTheme.dark().useMaterial3, isTrue);
    });

    test('light() includes WidgetXThemeExtension', () {
      final ext =
          WidgetXTheme.light().extension<WidgetXThemeExtension>();
      expect(ext, isNotNull);
    });

    test('dark() includes WidgetXThemeExtension', () {
      final ext =
          WidgetXTheme.dark().extension<WidgetXThemeExtension>();
      expect(ext, isNotNull);
    });

    test('WidgetXThemeExtension.light has correct primaryColor', () {
      expect(WidgetXThemeExtension.light.primaryColor,
          equals(WidgetXColors.primary));
    });

    test('copyWith overrides specified fields', () {
      const original = WidgetXThemeExtension.light;
      final copied = original.copyWith(primaryColor: Colors.red);
      expect(copied.primaryColor, equals(Colors.red));
      expect(copied.secondaryColor, equals(original.secondaryColor));
    });
  });
}
