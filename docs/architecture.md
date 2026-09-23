# Architecture

## Overview

WidgetX UI follows a **package-first monorepo** structure. The core design principle is that the reusable Flutter package (`packages/widgetx_ui`) remains fully independent of the showcase application (`apps/showcase`).

```
widgetx_ui/                        ← Monorepo root
│
├── packages/widgetx_ui/           ← Reusable Flutter package
│   ├── lib/widgetx_ui.dart        ← Public barrel export
│   ├── lib/src/                   ← Private implementation
│   └── test/                      ← Package tests
│
├── apps/showcase/                 ← Interactive showcase app
│   ├── lib/shell/                 ← Responsive app shell
│   ├── lib/routing/               ← go_router configuration
│   ├── lib/providers/             ← Riverpod state
│   ├── lib/screens/               ← Component documentation screens
│   ├── lib/templates/             ← Complete UI templates
│   ├── lib/catalog/               ← Demo UI helpers
│   └── lib/mock/                  ← Local mock data
│
├── docs/                          ← Documentation
├── .github/workflows/             ← CI/CD
└── ...
```

---

## Dependency direction

```
Showcase App
    │  depends on
    ▼
widgetx_ui Package
    │  uses
    ▼
Design Foundations (tokens)
```

The showcase app NEVER re-implements components. All UI elements come from the package.

---

## Package structure

### Foundations (`lib/src/foundations/`)

Centralized design tokens. No widget logic here — pure constants and values.

| File | Purpose |
|------|---------|
| `widgetx_colors.dart` | Semantic color palette |
| `widgetx_typography.dart` | Named text styles |
| `widgetx_spacing.dart` | Spacing scale |
| `widgetx_radius.dart` | Border-radius constants |
| `widgetx_shadows.dart` | Box shadow presets |
| `widgetx_motion.dart` | Animation durations and curves |
| `widgetx_breakpoints.dart` | Responsive breakpoints |

### Themes (`lib/src/themes/`)

| File | Purpose |
|------|---------|
| `widgetx_theme.dart` | `WidgetXTheme.light()` and `WidgetXTheme.dark()` |
| `widgetx_theme_extension.dart` | `ThemeExtension` carrying semantic tokens into `ThemeData` |

### Components

Each component category has its own directory under `lib/src/`. Components follow these conventions:

1. **File naming** — `widgetx_<name>.dart`
2. **Class naming** — `WidgetX<Name>`
3. **No hardcoded values** — all visual constants come from foundations
4. **Accessibility** — every interactive widget carries `semanticLabel` or similar
5. **Const constructors** — where the widget has no mutable default state
6. **No business logic** — components are purely presentational

### Public API (`lib/widgetx_ui.dart`)

The barrel file exports all public symbols. Internal implementation details are never exported.

---

## Showcase architecture

### Navigation

Uses [go_router](https://pub.dev/packages/go_router) with a `ShellRoute` that wraps all screens in the responsive `MainShell`. The shell handles:

- **Desktop** — persistent sidebar (240px) + top bar with search, theme toggle, accent picker
- **Tablet** — hamburger drawer + AppBar
- **Mobile** — hamburger drawer + AppBar

### State management

Uses [flutter_riverpod](https://riverpod.dev) with `SharedPreferences` persistence:

- `themeModeProvider` — persists `ThemeMode` across sessions
- `accentIndexProvider` — persists the selected accent color
- `favoritesProvider` — persists favorited routes
- `searchQueryProvider` — ephemeral search string
- `previewDeviceProvider` — ephemeral device preview selection

### Templates

Each template category follows this directory structure:

```
templates/<category>/
├── <main>_screen.dart
├── <sub>_screen.dart (where applicable)
└── (no separate widgets/ dir unless complex)
```

Templates use `MockData` from `lib/mock/mock_data.dart` for all data.

---

## Design principles

### Composition over inheritance

Prefer composing small widgets together rather than building deep inheritance hierarchies.

### Small, focused widgets

Each widget should do one thing well. Complex screens are composed from smaller primitives.

### Explicit customization

Sensible defaults with explicit opt-in customization. Avoid `dynamic` types.

### Testability

Every public component has corresponding widget tests. Tests cover rendering, interaction, disabled states, and semantics.
