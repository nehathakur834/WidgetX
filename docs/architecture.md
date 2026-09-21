# Architecture

WidgetX UI follows a package-first monorepo structure.

## Package Independence

The `widgetx_ui` package has no dependency on the showcase application.
The showcase app imports and uses the package but never modifies its internals.

## Design Token System

All visual values (colors, spacing, typography, radius, shadow, motion) are
defined as Dart constants in the `foundations/` directory.

Components never use hardcoded values — they always reference a token.

## Theme System

`WidgetXTheme.light()` and `WidgetXTheme.dark()` return Flutter `ThemeData`
objects built from the design tokens.

`WidgetXThemeExtension` carries WidgetX-specific tokens into Flutter's theme
system via `ThemeExtension<T>`.

## Accessibility

Every public component includes:
- Semantic labels via `Semantics`
- Proper button and form field roles
- Disabled state communication
- Minimum touch target sizes (44px minimum height on interactive controls)

## Responsive Layout

`WidgetXResponsive`, `WidgetXResponsiveBuilder`, and `WidgetXResponsiveContainer`
provide breakpoint-aware layout switching using `MediaQuery.sizeOf()`.

Breakpoints are configurable via `WidgetXBreakpointConfig`.
