import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ThemeMode provider
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt('themeMode') ?? ThemeMode.system.index;
    state = ThemeMode.values[index];
  }

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
  }
}

// Accent color provider — index into a list of seed colors
final accentIndexProvider = StateNotifierProvider<AccentIndexNotifier, int>(
  (ref) => AccentIndexNotifier(),
);

class AccentIndexNotifier extends StateNotifier<int> {
  AccentIndexNotifier() : super(0) {
    _load();
  }

  static const List<Color> accentColors = [
    Color(0xFF3B82F6), // Blue (default)
    Color(0xFF7C3AED), // Purple
    Color(0xFF10B981), // Green
    Color(0xFFF59E0B), // Amber
    Color(0xFFEF4444), // Red
    Color(0xFF14B8A6), // Teal
  ];

  static const List<String> accentNames = [
    'Blue',
    'Purple',
    'Green',
    'Amber',
    'Red',
    'Teal',
  ];

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getInt('accentIndex') ?? 0;
  }

  Future<void> setIndex(int index) async {
    state = index;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('accentIndex', index);
  }

  Color get currentColor => accentColors[state];
}
