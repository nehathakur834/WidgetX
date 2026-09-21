import 'package:flutter/material.dart';
import '../foundations/colors/widgetx_colors.dart';
import '../foundations/typography/widgetx_typography.dart';
import 'widgetx_theme_extension.dart';

/// Entry point for WidgetX UI theming.
///
/// Usage:
/// ```dart
/// MaterialApp(
///   theme: WidgetXTheme.light(),
///   darkTheme: WidgetXTheme.dark(),
///   themeMode: ThemeMode.system,
/// );
/// ```
abstract final class WidgetXTheme {
  /// Returns the WidgetX light [ThemeData].
  static ThemeData light() => _build(
        brightness: Brightness.light,
        colorScheme: _lightColorScheme,
        extension: WidgetXThemeExtension.light,
      );

  /// Returns the WidgetX dark [ThemeData].
  static ThemeData dark() => _build(
        brightness: Brightness.dark,
        colorScheme: _darkColorScheme,
        extension: WidgetXThemeExtension.dark,
      );

  static ThemeData _build({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required WidgetXThemeExtension extension,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: WidgetXTypography.textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      extensions: [extension],

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: WidgetXTypography.titleLarge.copyWith(
          color: colorScheme.onSurface,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        color: colorScheme.surface,
        margin: EdgeInsets.zero,
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        labelStyle: WidgetXTypography.bodyMedium,
        hintStyle: WidgetXTypography.bodyMedium.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Elevated button defaults
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: WidgetXTypography.labelLarge,
          minimumSize: const Size(0, 44),
        ),
      ),

      // Outlined button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: WidgetXTypography.labelLarge,
          minimumSize: const Size(0, 44),
        ),
      ),

      // Text button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: WidgetXTypography.labelLarge,
          minimumSize: const Size(0, 44),
        ),
      ),

      // Chip
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: colorScheme.surface,
      ),

      // Bottom sheet
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        elevation: 0,
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: WidgetXTypography.bodyMedium.copyWith(
          color: colorScheme.onInverseSurface,
        ),
      ),

      // Divider
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      // Navigation bar (bottom)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
        labelTextStyle: WidgetStateProperty.all(
          WidgetXTypography.labelMedium,
        ),
      ),

      // Navigation rail
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
        selectedLabelTextStyle: WidgetXTypography.labelMedium.copyWith(
          color: colorScheme.onPrimaryContainer,
        ),
        unselectedLabelTextStyle: WidgetXTypography.labelMedium.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Tab bar
      tabBarTheme: TabBarThemeData(
        labelStyle: WidgetXTypography.labelLarge,
        unselectedLabelStyle: WidgetXTypography.labelLarge,
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
    );
  }

  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: WidgetXColors.primary,
    onPrimary: WidgetXColors.onPrimary,
    primaryContainer: Color(0xFFDBEAFE),
    onPrimaryContainer: Color(0xFF1D3B6E),
    secondary: WidgetXColors.secondary,
    onSecondary: WidgetXColors.onSecondary,
    secondaryContainer: Color(0xFFEDE9FE),
    onSecondaryContainer: Color(0xFF3B1F6E),
    error: WidgetXColors.error,
    onError: WidgetXColors.onError,
    errorContainer: Color(0xFFFEE2E2),
    onErrorContainer: Color(0xFF7F1D1D),
    surface: WidgetXColors.surface,
    onSurface: WidgetXColors.onSurface,
    surfaceContainerHighest: Color(0xFFF1F5F9),
    onSurfaceVariant: WidgetXColors.onSurfaceVariant,
    outline: WidgetXColors.outline,
    outlineVariant: WidgetXColors.outlineVariant,
    inverseSurface: Color(0xFF1E293B),
    onInverseSurface: Color(0xFFF1F5F9),
    inversePrimary: Color(0xFF93C5FD),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    surfaceTint: WidgetXColors.primary,
  );

  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF93C5FD),
    onPrimary: Color(0xFF1D3B6E),
    primaryContainer: Color(0xFF1D4ED8),
    onPrimaryContainer: Color(0xFFDBEAFE),
    secondary: Color(0xFFC4B5FD),
    onSecondary: Color(0xFF3B1F6E),
    secondaryContainer: Color(0xFF5B21B6),
    onSecondaryContainer: Color(0xFFEDE9FE),
    error: Color(0xFFFCA5A5),
    onError: Color(0xFF7F1D1D),
    errorContainer: Color(0xFF991B1B),
    onErrorContainer: Color(0xFFFEE2E2),
    surface: WidgetXColors.surfaceDark,
    onSurface: WidgetXColors.onSurfaceDark,
    surfaceContainerHighest: WidgetXColors.surfaceVariantDark,
    onSurfaceVariant: WidgetXColors.onSurfaceVariantDark,
    outline: WidgetXColors.outlineDark,
    outlineVariant: Color(0xFF334155),
    inverseSurface: Color(0xFFF1F5F9),
    onInverseSurface: Color(0xFF1E293B),
    inversePrimary: WidgetXColors.primary,
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    surfaceTint: Color(0xFF93C5FD),
  );
}
