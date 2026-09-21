# Theming

WidgetX UI provides a complete Material 3–based theme system.

## Usage

```dart
MaterialApp(
  theme: WidgetXTheme.light(),
  darkTheme: WidgetXTheme.dark(),
  themeMode: ThemeMode.system,
);
```

## Accessing WidgetX Tokens in Widgets

```dart
final ext = Theme.of(context).extension<WidgetXThemeExtension>()!;
final primaryColor = ext.primaryColor;
```

## Customizing the Theme

Pass overrides to `ThemeData.copyWith()` after calling `WidgetXTheme.light()`:

```dart
theme: WidgetXTheme.light().copyWith(
  colorScheme: WidgetXTheme.light().colorScheme.copyWith(
    primary: Colors.teal,
  ),
),
```

## Color Tokens

All semantic color names are in `WidgetXColors`. The color scheme maps these
to Material 3 roles automatically.

## Typography Tokens

`WidgetXTypography` provides named `TextStyle` getters matching the Material 3
type scale.
