# Changelog

All notable changes to WidgetX UI are documented here.

This project follows [Semantic Versioning](https://semver.org/).

---

## [0.1.0] — Unreleased

### Added

#### Package: `widgetx_ui`

**Design Foundations**
- `WidgetXColors` — semantic color tokens (primary, secondary, surface, error, warning, success, info, outline, disabled, focus)
- `WidgetXTypography` — Material 3 type scale (display, headline, title, body, label, caption)
- `WidgetXSpacing` — spacing scale (xxs 2px → xxxl 64px)
- `WidgetXRadius` — border-radius tokens (xs 4px → full 9999px)
- `WidgetXShadows` — elevation shadow presets (sm, md, lg)
- `WidgetXMotion` — animation durations (fast 100ms, normal 200ms, slow 350ms, emphasis 500ms) and curves
- `WidgetXBreakpoints` — responsive breakpoints (mobile 0, tablet 600, desktop 1024, widescreen 1440)

**Themes**
- `WidgetXTheme.light()` — light Material 3 theme with WidgetX tokens
- `WidgetXTheme.dark()` — dark Material 3 theme with WidgetX tokens
- `WidgetXThemeExtension` — ThemeExtension carrying semantic color, spacing, radius, and duration tokens

**Buttons**
- `WidgetXButton` — primary, secondary, outlined, text, destructive variants; small/medium/large sizes; loading state; leading/trailing icons; full-width mode; accessibility semantics
- `WidgetXIconButton` — standard, filled, outlined, tonal variants; toggle state

**Inputs**
- `WidgetXTextField` — label, hint, helper/error text, prefix/suffix icons, disabled, read-only
- `WidgetXPasswordField` — visibility toggle
- `WidgetXSearchField` — search icon, clear button
- `WidgetXCheckbox` — label, helper/error text, tristate, disabled
- `WidgetXSwitch` — label, semantic toggle
- `WidgetXSlider` — label, value display, min/max/divisions
- `WidgetXRadio` — labeled radio button
- `WidgetXDropdown` — typed single-select

**Cards**
- `WidgetXCard` — title, subtitle, body, header, footer, leading, trailing, loading skeleton, selectable state, tap interaction
- `WidgetXExpandableCard` — animated expand/collapse with rotation chevron

**Dialogs & Sheets**
- `showWidgetXAlertDialog` — modal alert with confirm
- `showWidgetXConfirmDialog` — confirmation dialog with destructive option
- `WidgetXDialog` — generic dialog with custom body and `show()` helper
- `showWidgetXBottomSheet` — modal bottom sheet with optional title and drag handle
- `showWidgetXActionSheet` — labeled action list sheet; `WidgetXActionItem`

**Navigation**
- `WidgetXAppBar` — title, subtitle, actions, bottom; implements `PreferredSizeWidget`
- `WidgetXBottomNav` — `NavigationBar`-backed bottom navigation; `WidgetXNavItem`
- `WidgetXNavRail` — `NavigationRail`-backed side navigation; `WidgetXNavRailItem`
- `WidgetXTabBar` — styled tab bar; implements `PreferredSizeWidget`
- `WidgetXSegmentedControl` — `SegmentedButton`-backed multi-segment selector
- `WidgetXBreadcrumbs` — horizontal breadcrumb trail; `WidgetXBreadcrumbItem`
- `WidgetXStepper` — multi-step process widget; `WidgetXStepItem`

**Data Display**
- `WidgetXBadge` — primary, secondary, success, warning, error, info, neutral variants
- `WidgetXOverlayBadge` — dot or count overlay on any widget
- `WidgetXChip` — filled, outlined, suggestion; filter and input chip modes
- `WidgetXAvatar` — image URL, initials, or icon; five size variants
- `WidgetXAvatarGroup` — overlapping avatar stack with overflow count
- `WidgetXListTile` — title, subtitle, leading, trailing, selected, disabled
- `WidgetXKeyValueRow` — two-column key–value display
- `WidgetXDivider` — horizontal, vertical, and labeled variants
- `WidgetXEmptyState` — icon, title, description, illustration, action, error variant
- `WidgetXTimeline` — vertical event timeline; `WidgetXTimelineItem` with completed/active states
- `WidgetXAccordion` — multi-panel FAQ accordion with single/multiple mode; `WidgetXAccordionItem`
- `WidgetXDataTable` — sortable, selectable data table; loading and empty states

**Feedback**
- `showWidgetXSnackbar` — info, success, warning, error variants with optional action
- `WidgetXBanner` — dismissible inline status banner; live region support
- `WidgetXCircularProgress` — determinate and indeterminate; semantic label
- `WidgetXLinearProgress` — rounded, determinate and indeterminate
- `WidgetXSkeleton` — shimmer placeholder; circle mode; configurable size
- `WidgetXSkeletonText` — multi-line skeleton paragraph

**Layout**
- `WidgetXResponsive` — mobile/tablet/desktop/widescreen widget switcher
- `WidgetXResponsiveBuilder` — builder callback receiving `WidgetXScreenSize`
- `WidgetXResponsiveContainer` — max-width constrained container per breakpoint
- `WidgetXBreakpointConfig` — configurable breakpoint thresholds

**Utilities**
- `WidgetXFocusUtils` — `createFocusNode`, `focusRingDecoration`, `requestFocusNextFrame`

#### App: `showcase`

**State Management & Routing**
- `flutter_riverpod` — `ProviderScope` wraps the app; all mutable state in `StateNotifierProvider`
- `go_router` — `ShellRoute` drives all navigation; deep links work on web
- `ThemeModeNotifier` + `AccentIndexNotifier` — persisted to `shared_preferences`
- `searchQueryProvider`, `favoritesProvider`, `previewDeviceProvider` — live, reactive providers

**Shell & Navigation**
- `MainShell` — responsive shell: 240 px sidebar on desktop, drawer on tablet/mobile
- `_TopBar` — inline search, theme toggle, accent selector, GitHub link
- `_Sidebar` — sectioned nav (Overview / Components / Templates) with active-state highlight
- Breadcrumbs and route-aware active state via `GoRouterState.of(context).uri.path`

**15 UI Templates (all use `MockData`, no backend)**
- Auth: `LoginScreen`, `RegisterScreen`, `OnboardingScreen`
- `AnalyticsDashboardScreen` — stat cards, bar chart, transactions list
- E-Commerce: `EcommerceHomeScreen`, `ProductDetailsScreen`, `CartScreen`
- `FinanceDashboardScreen` — balance card, spending categories, recent transactions
- Real Estate: `PropertyHomeScreen`, `PropertyDetailsScreen`
- `SocialHomeScreen` — feed with stories, posts, likes
- `FoodHomeScreen` — category chips, restaurant cards
- `TaskDashboardScreen` — Kanban-style tasks with priorities
- `PortfolioScreen` — skills, projects, contact section
- `SettingsScreen` — grouped preference rows, theme/accent picker

**Animations (`flutter_animate`)**
- `LoginScreen` — staggered `fadeIn` + `slideY` on every form element
- `AnalyticsDashboardScreen` — header `slideY`, stat card grid `fadeIn`
- `HomeScreen._HeroBanner` — logo `scaleXY`, title `slideX`, pills `slideY`

**Mock Data**
- `MockData` — `MockProduct`, `MockTransaction`, `MockProperty`, `MockTask`, `MockPost` with rich static datasets

**Web**
- `web/index.html` updated: SEO meta, Open Graph tags, PWA viewport, loading spinner
- Web build configured with `--base-href /widgetx_ui/` for GitHub Pages

### Documentation

- `README.md` — full professional README with badges, architecture diagram, tech-stack table, theming examples, responsive breakpoints, state-management guide, navigation table, roadmap
- `CONTRIBUTING.md` — complete contributor guide (setup, branch naming, PR checklist, coding standards)
- `CODE_OF_CONDUCT.md` — Contributor Covenant v2.1
- `docs/architecture.md` — full monorepo architecture, dependency direction, package structure, showcase architecture
- `docs/theming.md` — complete theming guide: seed colors, ThemeExtension, component overrides, typography, persistence
- `docs/components.md` — full API reference for every public component
- `docs/getting-started.md` — step-by-step setup, path/git/pub.dev dependency options, first-component tutorial

### Infrastructure

- GitHub Actions CI (`flutter_ci.yml`): format check, `flutter analyze`, `flutter test`, web build with `--base-href /widgetx_ui/`
- GitHub Actions deploy (`deploy.yml`): auto-deploy showcase to GitHub Pages on push to `main`
- `analysis_options.yaml` with `prefer_const_constructors`, `avoid_print`, and other production-quality rules
- 97 tests covering buttons, cards, inputs, feedback, navigation, data display, dialogs, themes, foundations, and layout

---

## [0.0.1] — Initial scaffold

- Monorepo structure created (`packages/widgetx_ui`, `apps/showcase`, `docs/`, `.github/`)
- Flutter package and showcase app configured
- Basic `WidgetXButton` placeholder
