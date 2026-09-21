# Changelog

All notable changes to WidgetX UI are documented here.

This project follows [Semantic Versioning](https://semver.org/).

---

## [0.1.0] — Unreleased

### Added

- Design token foundations: color, typography, spacing, radius, shadows, motion, breakpoints
- `WidgetXTheme.light()` and `WidgetXTheme.dark()` using Material 3
- `WidgetXThemeExtension` for theme-level design tokens
- **Buttons**: `WidgetXButton` (primary, secondary, outlined, text, destructive), `WidgetXIconButton`
- **Inputs**: `WidgetXTextField`, `WidgetXPasswordField`, `WidgetXSearchField`, `WidgetXCheckbox`, `WidgetXSwitch`, `WidgetXSlider`, `WidgetXDropdown`, `WidgetXRadio`
- **Cards**: `WidgetXCard`, `WidgetXExpandableCard`
- **Dialogs**: `showWidgetXAlertDialog`, `showWidgetXConfirmDialog`, `WidgetXDialog`
- **Bottom sheets**: `showWidgetXBottomSheet`, `showWidgetXActionSheet`
- **Navigation**: `WidgetXAppBar`, `WidgetXBottomNav`, `WidgetXTabBar`
- **Data display**: `WidgetXBadge`, `WidgetXOverlayBadge`, `WidgetXChip`, `WidgetXAvatar`, `WidgetXAvatarGroup`, `WidgetXDivider`, `WidgetXListTile`, `WidgetXKeyValueRow`, `WidgetXEmptyState`
- **Feedback**: `showWidgetXSnackbar`, `WidgetXBanner`, `WidgetXCircularProgress`, `WidgetXLinearProgress`, `WidgetXSkeleton`, `WidgetXSkeletonText`
- **Layout**: `WidgetXResponsive`, `WidgetXResponsiveBuilder`, `WidgetXResponsiveContainer`
- **Utils**: `WidgetXFocusUtils`
- Comprehensive unit and widget tests (61 tests)
- Showcase application with category navigation, theme switcher, live component previews
- GitHub Actions CI pipeline
