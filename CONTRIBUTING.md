# Contributing to WidgetX UI

Thank you for your interest in contributing to WidgetX UI! Contributions of all kinds are welcome — bug reports, feature requests, documentation improvements, and code contributions.

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.10.0`
- Dart SDK `>=3.0.0`
- Git

### Fork and clone

```bash
git clone https://github.com/YOUR_USERNAME/widgetx_ui.git
cd widgetx_ui
```

### Install dependencies

```bash
# Install package dependencies
cd packages/widgetx_ui
flutter pub get

# Install showcase dependencies
cd ../../apps/showcase
flutter pub get
```

### Run the showcase app

```bash
cd apps/showcase
flutter run
```

---

## Project Structure

```
widgetx_ui/
├── packages/widgetx_ui/   # The reusable Flutter package
│   ├── lib/               # Public API
│   └── test/              # Package tests
└── apps/showcase/         # Interactive showcase app
    ├── lib/
    │   ├── templates/     # Complete UI templates
    │   ├── screens/       # Component demo screens
    │   ├── shell/         # Responsive app shell
    │   ├── providers/     # Riverpod providers
    │   └── mock/          # Mock data
    └── test/              # Showcase tests
```

---

## Development Guidelines

### Code style

- Follow the existing code style and naming conventions.
- All public WidgetX components must use the `WidgetX` prefix (e.g., `WidgetXButton`, `WidgetXCard`).
- Use `const` constructors wherever possible.
- Do not hardcode colors, spacing, or border-radius — use design tokens from `WidgetXColors`, `WidgetXSpacing`, `WidgetXRadius`, etc.
- Add Dart doc comments (`///`) to all public classes, constructors, and properties.

### Formatting and analysis

Before submitting a PR, always run:

```bash
# Format
dart format .

# Analyze
flutter analyze
```

Both must pass with zero issues.

### Tests

Every new component or significant change must include tests:

```bash
cd packages/widgetx_ui
flutter test
```

Test categories:
- **Unit tests** — design tokens, breakpoint logic, utilities
- **Widget tests** — rendering, interaction, disabled/loading states, semantics
- **Theme tests** — light/dark theme behavior

---

## Pull Request Process

1. **Create a feature branch** from `main`:
   ```bash
   git checkout -b feat/my-new-component
   ```

2. **Make your changes** following the guidelines above.

3. **Add or update tests** for your changes.

4. **Update documentation** if you changed public APIs.

5. **Run all checks**:
   ```bash
   cd packages/widgetx_ui && dart format . && flutter analyze && flutter test
   cd ../../apps/showcase && dart format . && flutter analyze
   ```

6. **Open a pull request** with a clear title and description:
   - What was changed
   - Why it was changed
   - Screenshots or recordings for UI changes
   - Any breaking changes

### PR title format

```
feat: add WidgetXDatePicker component
fix: correct WidgetXButton disabled state color
docs: update theming guide
test: add golden tests for WidgetXCard
chore: upgrade flutter_riverpod to 2.x
```

---

## Adding a New Component

1. Create the component file in `packages/widgetx_ui/lib/src/<category>/widgetx_<name>.dart`.
2. Export it from `packages/widgetx_ui/lib/widgetx_ui.dart`.
3. Write widget tests in `packages/widgetx_ui/test/<category>/<name>_test.dart`.
4. Add a demo to the appropriate showcase screen in `apps/showcase/lib/screens/`.

### Component checklist

- [ ] Uses `WidgetX` prefix
- [ ] Accepts `semanticLabel` or similar accessibility parameter
- [ ] Works in both light and dark theme
- [ ] Uses design token constants (no hardcoded values)
- [ ] Has `const` constructor
- [ ] Has Dart doc comments
- [ ] Has widget tests covering rendering, states, and interactions
- [ ] Handles disabled state where applicable

---

## Adding a New Template

1. Create a directory under `apps/showcase/lib/templates/<category>/`.
2. Add the screen file using WidgetX components throughout.
3. Register the route in `apps/showcase/lib/routing/app_router.dart`.
4. Add the nav item to `apps/showcase/lib/shell/main_shell.dart`.

---

## Reporting Bugs

Open a GitHub issue with:

- A clear, descriptive title
- Steps to reproduce
- Expected vs. actual behavior
- Flutter version and platform

---

## License

By contributing to WidgetX UI, you agree that your contributions will be licensed under the MIT License.
