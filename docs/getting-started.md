# Getting Started with WidgetX UI

This guide walks you through cloning, running, and integrating the WidgetX UI design system into your own Flutter project.

---

## Prerequisites

| Tool    | Minimum Version |
|---------|-----------------|
| Flutter | 3.22.0          |
| Dart    | 3.4.0           |
| Git     | Any recent      |

Check your versions:

```bash
flutter --version
dart --version
```

---

## Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/widgetx_ui.git
cd widgetx_ui
```

---

## Project Structure

```
widgetx_ui/
├── packages/
│   └── widgetx_ui/          # Reusable Flutter UI package
├── apps/
│   └── showcase/            # Storybook-style demo app
├── docs/                    # Documentation
└── .github/workflows/       # CI/CD
```

---

## Running the Showcase App

### 1. Get dependencies

```bash
cd apps/showcase
flutter pub get
```

### 2. Run on your target platform

```bash
# Mobile (connected device or emulator)
flutter run

# Web
flutter run -d chrome

# Desktop (macOS)
flutter run -d macos
```

The showcase app works on **Android, iOS, Web, macOS, Windows, and Linux**.

---

## Running the Package Tests

```bash
cd packages/widgetx_ui
flutter pub get
flutter test
```

To run with coverage:

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## Using the Package in Your Own Project

### Option A — Path dependency (local development)

In your `pubspec.yaml`:

```yaml
dependencies:
  widgetx_ui:
    path: ../packages/widgetx_ui
```

### Option B — Git dependency

```yaml
dependencies:
  widgetx_ui:
    git:
      url: https://github.com/YOUR_USERNAME/widgetx_ui.git
      path: packages/widgetx_ui
```

### Option C — pub.dev (once published)

```yaml
dependencies:
  widgetx_ui: ^0.1.0
```

---

## Integrating the Theme

```dart
import 'package:widgetx_ui/widgetx_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: WidgetXTheme.light(),
      darkTheme: WidgetXTheme.dark(),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
```

---

## Using Your First Component

```dart
import 'package:widgetx_ui/widgetx_ui.dart';

// Primary button
WidgetXButton(
  label: 'Get Started',
  variant: WidgetXButtonVariant.primary,
  onPressed: () {},
)

// Text field with validation
WidgetXTextField(
  label: 'Email',
  hint: 'you@example.com',
  keyboardType: TextInputType.emailAddress,
)

// Card
WidgetXCard(
  title: const Text('My Card'),
  body: const Text('Card content goes here.'),
  onTap: () {},
)
```

---

## Customizing the Accent Color

Pass a `seedColor` to generate a full Material 3 tonal palette:

```dart
MaterialApp(
  theme: WidgetXTheme.light(seedColor: const Color(0xFF7C3AED)),
  darkTheme: WidgetXTheme.dark(seedColor: const Color(0xFF7C3AED)),
)
```

---

## Responsive Layouts

Use `WidgetXResponsive` to adapt layouts across breakpoints:

```dart
WidgetXResponsive(
  mobile: const MobileView(),
  tablet: const TabletView(),
  desktop: const DesktopView(),
)
```

Default breakpoints:

| Breakpoint | Width         |
|------------|---------------|
| Mobile     | 0 – 599 px    |
| Tablet     | 600 – 1023 px |
| Desktop    | 1024 px +     |

---

## Building for Web

```bash
cd apps/showcase
flutter build web --base-href /widgetx_ui/
```

The output is in `build/web/`. The GitHub Actions CI automatically deploys this to GitHub Pages on every push to `main`.

---

## Static Analysis and Formatting

```bash
# From either package or app directory
flutter analyze
dart format .

# From the repository root (checks both)
dart format packages/widgetx_ui apps/showcase --set-exit-if-changed
```

---

## Next Steps

- Read the [Architecture Guide](architecture.md) to understand the monorepo structure.
- Read the [Theming Guide](theming.md) to learn how to customize colors, typography, and component defaults.
- Read the [Accessibility Guide](accessibility.md) for best practices.
- Browse the [Component Catalog](components.md) for API details on every component.
- Read [CONTRIBUTING.md](../CONTRIBUTING.md) before opening a pull request.
