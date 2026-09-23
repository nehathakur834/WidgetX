# Component Catalog

Complete API reference for all public WidgetX UI components. All components are exported from the main barrel file — `import 'package:widgetx_ui/widgetx_ui.dart';`.

---

## Buttons

### `WidgetXButton`

A versatile button supporting multiple visual variants, sizes, icons, and states.

```dart
WidgetXButton(
  label: 'Continue',
  variant: WidgetXButtonVariant.primary,
  size: WidgetXButtonSize.medium,
  onPressed: () {},
)
```

**Properties**

| Property          | Type                    | Default                       | Description                           |
|-------------------|-------------------------|-------------------------------|---------------------------------------|
| `label`           | `String`                | required                      | Button text label                     |
| `onPressed`       | `VoidCallback?`         | required                      | Tap handler; `null` disables button   |
| `variant`         | `WidgetXButtonVariant`  | `.primary`                    | Visual style                          |
| `size`            | `WidgetXButtonSize`     | `.medium`                     | Small, medium, or large               |
| `leadingIcon`     | `Widget?`               | `null`                        | Icon before the label                 |
| `trailingIcon`    | `Widget?`               | `null`                        | Icon after the label                  |
| `isLoading`       | `bool`                  | `false`                       | Shows a spinner and disables input    |
| `isFullWidth`     | `bool`                  | `false`                       | Stretches to fill available width     |
| `semanticLabel`   | `String?`               | `null`                        | Overrides the accessibility label     |

**Variants:** `primary`, `secondary`, `outlined`, `text`, `destructive`

**Sizes:** `small`, `medium`, `large`

---

### `WidgetXIconButton`

A circular or square icon-only button.

```dart
WidgetXIconButton(
  icon: const Icon(Icons.favorite_outline),
  onPressed: () {},
  tooltip: 'Add to favorites',
)
```

---

## Inputs

### `WidgetXTextField`

A Material 3–styled text field with label, helper text, error handling, and icon slots.

```dart
WidgetXTextField(
  controller: _controller,
  label: 'Email address',
  hint: 'you@example.com',
  helperText: 'We will never share your email.',
  errorText: _error,
  prefixIcon: const Icon(Icons.email_outlined),
  keyboardType: TextInputType.emailAddress,
)
```

**Properties**

| Property          | Type                    | Default | Description                          |
|-------------------|-------------------------|---------|--------------------------------------|
| `controller`      | `TextEditingController?`| `null`  | Optional controller                  |
| `label`           | `String?`               | `null`  | Floating label text                  |
| `hint`            | `String?`               | `null`  | Placeholder text                     |
| `helperText`      | `String?`               | `null`  | Persistent helper below the field    |
| `errorText`       | `String?`               | `null`  | Error message (overrides helper)     |
| `prefixIcon`      | `Widget?`               | `null`  | Leading icon inside the field        |
| `suffixIcon`      | `Widget?`               | `null`  | Trailing icon inside the field       |
| `obscureText`     | `bool`                  | `false` | Hides input characters               |
| `enabled`         | `bool`                  | `true`  | Disables the field when `false`      |
| `readOnly`        | `bool`                  | `false` | Prevents editing                     |
| `onChanged`       | `ValueChanged<String>?` | `null`  | Called on every keystroke            |
| `keyboardType`    | `TextInputType?`        | `null`  | Keyboard layout hint                 |

---

### `WidgetXCheckbox`

An accessible checkbox with a label.

```dart
WidgetXCheckbox(
  value: _checked,
  onChanged: (v) => setState(() => _checked = v ?? false),
  label: 'Accept terms',
)
```

---

### `WidgetXRadio<T>`

A radio button tied to a typed value.

```dart
WidgetXRadio<String>(
  value: 'option_a',
  groupValue: _selected,
  onChanged: (v) => setState(() => _selected = v!),
  label: 'Option A',
)
```

---

### `WidgetXSwitch`

A labeled toggle switch.

```dart
WidgetXSwitch(
  value: _enabled,
  onChanged: (v) => setState(() => _enabled = v),
  label: 'Notifications',
)
```

---

### `WidgetXSlider`

A continuous or discrete slider.

```dart
WidgetXSlider(
  value: _volume,
  min: 0,
  max: 100,
  onChanged: (v) => setState(() => _volume = v),
  label: 'Volume',
)
```

---

### `WidgetXDropdown<T>`

A single-select dropdown.

```dart
WidgetXDropdown<String>(
  value: _selected,
  label: 'Country',
  items: const ['US', 'UK', 'CA'],
  onChanged: (v) => setState(() => _selected = v),
)
```

---

## Cards

### `WidgetXCard`

A general-purpose card with optional header, footer, tap handler, and loading/selected states.

```dart
WidgetXCard(
  title: const Text('Card Title'),
  subtitle: const Text('Optional subtitle'),
  body: const Text('Card body content.'),
  onTap: () {},
  semanticDescription: 'Open this item',
)
```

**Properties**

| Property               | Type         | Default | Description                          |
|------------------------|--------------|---------|--------------------------------------|
| `title`                | `Widget?`    | `null`  | Card header widget                   |
| `subtitle`             | `Widget?`    | `null`  | Secondary header widget              |
| `body`                 | `Widget?`    | `null`  | Main content                         |
| `footer`               | `Widget?`    | `null`  | Bottom content row                   |
| `onTap`                | `VoidCallback?`| `null`| Tap handler                          |
| `isLoading`            | `bool`       | `false` | Shows skeleton shimmer               |
| `isSelected`           | `bool`       | `false` | Selected visual state                |
| `semanticDescription`  | `String?`    | `null`  | Screen-reader description            |
| `padding`              | `EdgeInsetsGeometry?`| `null`| Custom padding                  |

---

### `WidgetXExpandableCard`

A card that reveals additional content on tap.

```dart
WidgetXExpandableCard(
  title: const Text('Show More'),
  expandedContent: const Text('Hidden content here.'),
)
```

---

## Dialogs and Sheets

### `WidgetXDialog`

An accessible dialog with title, content, and configurable actions.

```dart
showDialog(
  context: context,
  builder: (_) => WidgetXDialog(
    title: 'Confirm Delete',
    content: const Text('This action cannot be undone.'),
    primaryAction: WidgetXDialogAction(
      label: 'Delete',
      isDestructive: true,
      onPressed: () => Navigator.pop(context),
    ),
    secondaryAction: WidgetXDialogAction(
      label: 'Cancel',
      onPressed: () => Navigator.pop(context),
    ),
  ),
);
```

---

### `WidgetXBottomSheet`

A styled modal bottom sheet with drag handle and safe-area support.

```dart
showModalBottomSheet(
  context: context,
  builder: (_) => WidgetXBottomSheet(
    title: 'Options',
    child: Column(children: [ /* ... */ ]),
  ),
);
```

---

## Navigation

### `WidgetXAppBar`

A Material 3 app bar with optional subtitle and action slots.

```dart
WidgetXAppBar(
  title: 'Settings',
  subtitle: 'Manage your preferences',
  actions: [
    IconButton(icon: const Icon(Icons.search), onPressed: () {}),
  ],
)
```

---

### `WidgetXBottomNav`

A bottom navigation bar.

```dart
WidgetXBottomNav(
  currentIndex: _index,
  onTap: (i) => setState(() => _index = i),
  items: const [
    WidgetXNavItem(icon: Icons.home_outlined, label: 'Home'),
    WidgetXNavItem(icon: Icons.search_outlined, label: 'Search'),
    WidgetXNavItem(icon: Icons.person_outline, label: 'Profile'),
  ],
)
```

---

### `WidgetXNavRail`

A navigation rail for tablet/desktop layouts.

```dart
WidgetXNavRail(
  selectedIndex: _index,
  onDestinationSelected: (i) => setState(() => _index = i),
  destinations: const [
    WidgetXNavDestination(icon: Icons.home_outlined, label: 'Home'),
    WidgetXNavDestination(icon: Icons.search_outlined, label: 'Search'),
  ],
)
```

---

### `WidgetXTabBar`

A styled tab bar with optional indicator.

```dart
WidgetXTabBar(
  controller: _tabController,
  tabs: const ['All', 'Active', 'Archived'],
)
```

---

### `WidgetXSegmentedControl`

A segmented button control for mutually exclusive options.

```dart
WidgetXSegmentedControl(
  options: const ['Day', 'Week', 'Month'],
  selectedIndex: _selected,
  onChanged: (i) => setState(() => _selected = i),
)
```

---

### `WidgetXBreadcrumbs`

A horizontal breadcrumb trail.

```dart
WidgetXBreadcrumbs(
  items: [
    WidgetXBreadcrumbItem(label: 'Home', onTap: () {}),
    WidgetXBreadcrumbItem(label: 'Products', onTap: () {}),
    WidgetXBreadcrumbItem(label: 'Details'),
  ],
)
```

---

### `WidgetXStepper`

A step-based progress indicator.

```dart
WidgetXStepper(
  steps: const ['Details', 'Payment', 'Confirm'],
  currentStep: _step,
)
```

---

## Data Display

### `WidgetXBadge`

A small count or status indicator.

```dart
WidgetXBadge(
  count: 3,
  child: const Icon(Icons.notifications_outlined),
)
```

---

### `WidgetXChip`

A compact, interactive tag.

```dart
WidgetXChip(
  label: 'Flutter',
  onTap: () {},
  isSelected: true,
)
```

---

### `WidgetXAvatar`

A circular avatar with image, initials, or icon fallback.

```dart
WidgetXAvatar(
  name: 'Jane Doe',
  imageUrl: 'https://example.com/jane.jpg',
  size: WidgetXAvatarSize.medium,
)
```

---

### `WidgetXDivider`

A horizontal divider with optional label.

```dart
const WidgetXDivider()

WidgetXDivider(label: 'Or continue with')
```

---

### `WidgetXTimeline`

A vertical timeline with customizable items.

```dart
WidgetXTimeline(
  items: [
    WidgetXTimelineItem(title: 'Order Placed', subtitle: '9:00 AM'),
    WidgetXTimelineItem(title: 'Processing', subtitle: '10:30 AM'),
    WidgetXTimelineItem(title: 'Delivered', subtitle: '3:15 PM', isCompleted: true),
  ],
)
```

---

### `WidgetXAccordion`

An expandable accordion panel.

```dart
WidgetXAccordion(
  title: 'Frequently Asked Questions',
  child: const Text('Answer content here.'),
)
```

---

### `WidgetXDataTable`

A responsive data table with sortable columns.

```dart
WidgetXDataTable(
  columns: const ['Name', 'Role', 'Status'],
  rows: [
    ['Jane Doe', 'Designer', 'Active'],
    ['John Smith', 'Engineer', 'Active'],
  ],
)
```

---

### `WidgetXListTile`

A standard list item with leading, title, subtitle, and trailing.

```dart
WidgetXListTile(
  leading: const Icon(Icons.person_outline),
  title: 'Jane Doe',
  subtitle: 'UI Designer',
  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
  onTap: () {},
)
```

---

### `WidgetXEmptyState`

A placeholder for empty lists or screens.

```dart
WidgetXEmptyState(
  icon: Icons.inbox_outlined,
  title: 'No items yet',
  description: 'Items you add will appear here.',
  action: WidgetXButton(label: 'Add Item', onPressed: () {}),
)
```

---

## Feedback

### `WidgetXSnackbar`

A helper to show a themed snackbar.

```dart
WidgetXSnackbar.show(
  context,
  message: 'Saved successfully',
  variant: WidgetXSnackbarVariant.success,
)
```

**Variants:** `info`, `success`, `warning`, `error`

---

### `WidgetXProgressIndicator`

A linear or circular progress indicator.

```dart
// Determinate
WidgetXProgressIndicator(value: 0.6)

// Indeterminate
const WidgetXProgressIndicator()
```

---

### `WidgetXSkeleton`

A shimmer loading placeholder.

```dart
const WidgetXSkeleton(width: 200, height: 20)
```

---

### `WidgetXBanner`

An informational banner with an icon and optional action.

```dart
WidgetXBanner(
  message: 'Your session will expire in 5 minutes.',
  variant: WidgetXBannerVariant.warning,
  onDismiss: () {},
)
```

**Variants:** `info`, `success`, `warning`, `error`

---

## Layout

### `WidgetXResponsive`

A responsive layout switcher.

```dart
WidgetXResponsive(
  mobile: const MobileView(),
  tablet: const TabletView(),
  desktop: const DesktopView(),
)
```

You can also use the builder variant for access to the current breakpoint:

```dart
WidgetXResponsive.builder(
  builder: (context, breakpoint) {
    return breakpoint == WidgetXBreakpoint.mobile
        ? const MobileView()
        : const DesktopView();
  },
)
```

---

## Design Tokens

### `WidgetXSpacing`

```dart
WidgetXSpacing.xxs  // 2
WidgetXSpacing.xs   // 4
WidgetXSpacing.sm   // 8
WidgetXSpacing.md   // 16
WidgetXSpacing.lg   // 24
WidgetXSpacing.xl   // 32
WidgetXSpacing.xxl  // 48
WidgetXSpacing.xxxl // 64
```

### `WidgetXRadius`

```dart
WidgetXRadius.xs    // 4
WidgetXRadius.sm    // 8
WidgetXRadius.md    // 12
WidgetXRadius.lg    // 16
WidgetXRadius.xl    // 24
WidgetXRadius.full  // 999 (pill shape)
```

### `WidgetXMotion`

```dart
WidgetXMotion.fast    // 100ms
WidgetXMotion.normal  // 200ms
WidgetXMotion.slow    // 350ms
WidgetXMotion.emphasis // 500ms

WidgetXMotion.standard      // easeInOut
WidgetXMotion.decelerate    // easeOut
WidgetXMotion.accelerate    // easeIn
```

---

## Accessibility

All WidgetX components:

- Include meaningful `Semantics` labels by default.
- Support keyboard activation and `Tab` focus order.
- Render a visible focus ring using `ColorScheme.primary`.
- Enforce a minimum touch target of 44 × 44 dp.
- Respect `MediaQuery.disableAnimations` to honor reduced-motion preferences.

For custom semantic labels, use the `semanticLabel` or `semanticDescription` property where available.
