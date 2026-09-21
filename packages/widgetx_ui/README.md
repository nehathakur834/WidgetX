# widgetx_ui

A reusable Flutter design system package — part of the WidgetX UI project.

## Features

- Design tokens: color, typography, spacing, radius, shadows, motion, breakpoints
- Light and dark themes (Material 3)
- ThemeExtension support
- Buttons, inputs, cards, dialogs, navigation, data display, feedback, layout components
- Accessibility semantics built in
- No backend dependencies

## Installation

```yaml
dependencies:
  widgetx_ui:
    path: ../packages/widgetx_ui
```

## Usage

```dart
import 'package:widgetx_ui/widgetx_ui.dart';

// Wrap your app with the theme
MaterialApp(
  theme: WidgetXTheme.light(),
  darkTheme: WidgetXTheme.dark(),
  themeMode: ThemeMode.system,
);

// Use a button
WidgetXButton(
  label: 'Continue',
  variant: WidgetXButtonVariant.primary,
  onPressed: () {},
)
```

## License

MIT
