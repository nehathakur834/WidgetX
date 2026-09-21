import 'package:flutter/material.dart';

/// An [InheritedWidget] that exposes [ThemeMode] and a callback to change it.
class ThemeController extends InheritedWidget {
  const ThemeController({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
    required super.child,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  static ThemeController of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<ThemeController>();
    assert(result != null, 'No ThemeController found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ThemeController oldWidget) =>
      themeMode != oldWidget.themeMode;
}
