# WidgetX UI

A professional, open-source Flutter design system built for consistency, accessibility, and scalability.

[![CI](https://github.com/YOUR_USERNAME/widgetx_ui/actions/workflows/flutter_ci.yml/badge.svg)](https://github.com/YOUR_USERNAME/widgetx_ui/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## Overview

WidgetX UI is a reusable Flutter UI package and showcase application designed to help developers build production-quality applications faster with a consistent visual language.

| Feature | Status |
|---------|--------|
| Design tokens (color, type, spacing, radius, shadow, motion) | ✅ |
| Light & dark themes | ✅ |
| Material 3 foundation | ✅ |
| Buttons | ✅ |
| Inputs (text, password, search, checkbox, radio, switch, slider, dropdown) | ✅ |
| Cards (basic, expandable, selectable) | ✅ |
| Dialogs & bottom sheets | ✅ |
| Navigation (app bar, bottom nav, tab bar) | ✅ |
| Data display (badge, chip, avatar, divider, list tile, empty state) | ✅ |
| Feedback (snackbar, banner, progress, skeleton) | ✅ |
| Responsive layout utilities | ✅ |
| Accessibility semantics | ✅ |
| Unit & widget tests | ✅ |
| Showcase application | ✅ |
| GitHub Actions CI | ✅ |

---

## Monorepo Structure

```
widgetx_ui/
├── packages/
│   └── widgetx_ui/        # Reusable Flutter package
├── apps/
│   └── showcase/          # Interactive showcase application
├── docs/                  # Architecture and guide documents
├── .github/workflows/     # CI pipeline
├── README.md
├── CHANGELOG.md
└── LICENSE
```

---

## Quick Start

### 1. Add the package to your app

```yaml
# pubspec.yaml
dependencies:
  widgetx_ui:
    path: ../packages/widgetx_ui  # local path
    # OR once published:
    # widgetx_ui: ^0.1.0
```

### 2. Configure the theme

```dart
import 'package:widgetx_ui/widgetx_ui.dart';

MaterialApp(
  theme: WidgetXTheme.light(),
  darkTheme: WidgetXTheme.dark(),
  themeMode: ThemeMode.system,
  home: const HomeScreen(),
);
```

### 3. Use components

```dart
WidgetXButton(
  label: 'Get started',
  variant: WidgetXButtonVariant.primary,
  onPressed: () {},
)

WidgetXTextField(
  label: 'Email',
  hint: 'you@example.com',
)

WidgetXCard(
  title: Text('Hello'),
  body: Text('WidgetX UI'),
)
```

---

## Running the Showcase App

```bash
cd apps/showcase
flutter pub get
flutter run -d chrome   # Web
flutter run             # Mobile / desktop
```

---

## Running Tests

```bash
cd packages/widgetx_ui
flutter test
```

---

## Development

See [docs/contributing.md](docs/contributing.md) for contribution guidelines.

---

## License

MIT — see [LICENSE](LICENSE).

---

## Author

**YOUR NAME**  
GitHub: https://github.com/YOUR_USERNAME  
LinkedIn: YOUR_LINKEDIN_URL  
Portfolio: YOUR_PORTFOLIO_URL
