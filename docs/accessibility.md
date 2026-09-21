# Accessibility

Accessibility is a first-class feature in WidgetX UI.

## What Is Included

- **Semantic labels** on all interactive components
- **Button roles** — every button has `Semantics(button: true)`
- **Form field labels** — text fields declare `Semantics(textField: true, label: ...)`
- **Focus order** — Flutter's default focus traversal is respected
- **Disabled states** — disabled components report `Semantics(enabled: false)`
- **Minimum touch targets** — interactive controls have a minimum height of 44px
- **Live regions** — `WidgetXBanner` uses `Semantics(liveRegion: true)`

## Testing Accessibility

Run the semantic tree dump in tests:

```dart
expect(tester.getSemantics(find.byType(WidgetXButton)).label, 'Submit');
```

## Recommendations

- Always provide a `semanticLabel` when the visual label alone is ambiguous.
- For icon-only buttons, `semanticLabel` is required.
- Avoid wrapping already-accessible Flutter widgets in extra `Semantics` widgets.
