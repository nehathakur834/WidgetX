# Theming Guide

WidgetX UI is built on top of Flutter's Material 3 system with additional design tokens and theme extensions that give you full control over every visual aspect of your application.

---

## Quick Start

```dart
MaterialApp(
  theme: WidgetXTheme.light(),
  darkTheme: WidgetXTheme.dark(),
  themeMode: ThemeMode.system,
  home: const HomeScreen(),
)
```

That's all you need to get a complete, consistent light/dark theme including all component defaults.

---

## Accent Colors (Seed Colors)

Both `WidgetXTheme.light()` and `WidgetXTheme.dark()` accept an optional `seedColor` parameter. Flutter's Material 3 color scheme generation derives a full tonal palette from a single seed color.

```dart
MaterialApp(
  theme: WidgetXTheme.light(seedColor: const Color(0xFF7C3AED)),
  darkTheme: WidgetXTheme.dark(seedColor: const Color(0xFF7C3AED)),
  themeMode: ThemeMode.system,
)
```

If `seedColor` is omitted, the default WidgetX blue (`#3B82F6`) is used.

### Built-in Accent Palette

The showcase app ships six curated accent colors:

| Name   | Hex       |
|--------|-----------|
| Blue   | `#3B82F6` |
| Purple | `#7C3AED` |
| Green  | `#10B981` |
| Amber  | `#F59E0B` |
| Red    | `#EF4444` |
| Teal   | `#14B8A6` |

---

## Light and Dark Themes

### `WidgetXTheme.light({Color? seedColor})`

Returns a `ThemeData` configured for light mode with:

- Material 3 enabled
- `ColorScheme.fromSeed(...)` with `brightness: Brightness.light`
- Roboto / system font via `google_fonts`
- Custom component themes (button padding, card elevation, input decoration)
- `WidgetXThemeExtension` attached for design-token access

### `WidgetXTheme.dark({Color? seedColor})`

Same as above with `brightness: Brightness.dark`. All semantic colors are automatically adjusted for dark mode by Flutter's color-scheme generation.

---

## Theme Extensions

WidgetX ships a `WidgetXThemeExtension` that exposes design tokens directly from the theme tree. This avoids scattering token constants throughout widget code.

### Accessing the Extension

```dart
final ext = Theme.of(context).extension<WidgetXThemeExtension>();
final surface = ext?.surfaceContainer;
```

### Available Properties

| Property            | Description                             |
|---------------------|-----------------------------------------|
| `surfaceContainer`  | Surface with slight tonal elevation     |
| `borderRadius`      | Default card/control border radius      |
| `focusColor`        | Accessible focus ring color             |
| `disabledOpacity`   | Opacity applied to disabled controls    |
| `animationDuration` | Default transition duration             |

### Defining Custom Overrides

You can add your own tokens to the theme extension:

```dart
WidgetXTheme.light().copyWith(
  extensions: [
    WidgetXThemeExtension(
      surfaceContainer: const Color(0xFFF0F4FF),
      borderRadius: 12.0,
    ),
  ],
)
```

---

## Component Themes

Every Material component used inside WidgetX has its defaults configured at the theme level. You never need to pass style props to individual widgets for global customization — override the component theme instead.

### Example: Changing Button Shape

```dart
WidgetXTheme.light().copyWith(
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ),
  ),
)
```

### Example: Changing Card Elevation

```dart
WidgetXTheme.light().copyWith(
  cardTheme: const CardThemeData(elevation: 4),
)
```

---

## Typography

Typography is configured using `GoogleFonts` at the theme level. The full `TextTheme` is provided, respecting platform accessibility settings including font scaling.

To swap the font globally:

```dart
import 'package:google_fonts/google_fonts.dart';

WidgetXTheme.light().copyWith(
  textTheme: GoogleFonts.interTextTheme(),
)
```

### Typography Scale Reference

| Style            | Use Case                          |
|------------------|-----------------------------------|
| `displayLarge`   | Hero numbers, huge headlines      |
| `displayMedium`  | Large display text                |
| `headlineLarge`  | Page titles                       |
| `headlineMedium` | Section headings                  |
| `titleLarge`     | Card headings, dialog titles      |
| `titleMedium`    | List headings                     |
| `bodyLarge`      | Primary body copy                 |
| `bodyMedium`     | Secondary body copy               |
| `bodySmall`      | Captions, metadata                |
| `labelLarge`     | Buttons, chips                    |
| `labelMedium`    | Tags, badges, secondary labels    |
| `labelSmall`     | Overlines, sidebar categories     |

---

## Color Scheme Reference

WidgetX relies exclusively on the Material 3 `ColorScheme` — no hardcoded color values in components. The key roles used:

| Role                  | Use Case                              |
|-----------------------|---------------------------------------|
| `primary`             | Brand color, filled buttons           |
| `onPrimary`           | Content on primary-colored surfaces   |
| `primaryContainer`    | Tinted backgrounds, active states     |
| `onPrimaryContainer`  | Content on primary containers         |
| `secondary`           | Complementary brand color             |
| `secondaryContainer`  | Tags, chips                           |
| `surface`             | Default background                    |
| `surfaceVariant`      | Slightly elevated surfaces            |
| `onSurface`           | Default text/icon color               |
| `onSurfaceVariant`    | Secondary text, placeholder text      |
| `outline`             | Borders, dividers                     |
| `outlineVariant`      | Subtle borders                        |
| `error`               | Error states, destructive actions     |
| `onError`             | Content on error-colored surfaces     |

---

## Dynamic Color (Android 12+)

To support Android 12 dynamic color (Material You), wrap your app with `DynamicColorBuilder` before passing the seed to WidgetX themes:

```dart
import 'package:dynamic_color/dynamic_color.dart';

DynamicColorBuilder(
  builder: (lightDynamic, darkDynamic) {
    final seed = lightDynamic?.primary ?? const Color(0xFF3B82F6);
    return MaterialApp(
      theme: WidgetXTheme.light(seedColor: seed),
      darkTheme: WidgetXTheme.dark(seedColor: seed),
    );
  },
)
```

> **Note:** The `dynamic_color` package is an optional dependency. WidgetX does not require it — add it only if you want dynamic color support.

---

## Theme Mode Persistence

The showcase app persists the user's theme choice using `shared_preferences` via the `ThemeModeNotifier` Riverpod provider. To replicate this in your own app:

```dart
// In your Riverpod provider
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
```

---

## High-Contrast and Accessibility

WidgetX does not currently ship explicit high-contrast color schemes. However:

- All semantic colors are derived from Material 3's contrast-aware tonal palette.
- Text colors maintain at least a 4.5:1 contrast ratio against their backgrounds in both light and dark modes by default.
- Focus colors use `ColorScheme.primary` with a visible ring.
- Disabled states use `ColorScheme.onSurface.withValues(alpha: 0.38)`.

To support the system high-contrast mode explicitly, override `MediaQuery.highContrast` or use `WidgetsBinding.instance.platformDispatcher.accessibilityFeatures.highContrast`.

---

## Reduced Motion

Component animations in WidgetX respect Flutter's `MediaQuery.reduceMotion` setting where practical:

```dart
final reduce = MediaQuery.of(context).disableAnimations;
final duration = reduce ? Duration.zero : WidgetXMotion.normal;
```

Use `WidgetXMotion` constants for all durations in custom components to stay consistent.

---

## Summary

| Goal                             | API                                             |
|----------------------------------|-------------------------------------------------|
| Apply default themes             | `WidgetXTheme.light()` / `.dark()`              |
| Change accent color              | `WidgetXTheme.light(seedColor: myColor)`        |
| Override a component theme       | `themeData.copyWith(cardTheme: ...)`            |
| Access design tokens in a widget | `Theme.of(ctx).extension<WidgetXThemeExtension>()` |
| Swap typography                  | `themeData.copyWith(textTheme: ...)`            |
| Persist theme choice             | `ThemeModeNotifier` + `shared_preferences`      |
