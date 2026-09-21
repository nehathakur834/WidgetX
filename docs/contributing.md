# Contributing

Thank you for contributing to WidgetX UI.

## Before Opening a Pull Request

1. Create a feature branch from `main`.
2. Follow existing naming conventions (`WidgetX` prefix for public APIs).
3. Add or update tests for all new or changed behavior.
4. Update documentation for any changed public API.
5. Run formatting: `dart format .`
6. Run analysis: `flutter analyze`
7. Run tests: `flutter test`
8. Explain any breaking changes clearly in your PR description.

## Coding Standards

- Use `const` constructors wherever possible.
- Follow Material 3 patterns unless there is a clear reason not to.
- Keep widgets focused and single-purpose.
- Never include business logic inside UI components.
- All public APIs must have Dart documentation comments.

## Breaking Change Policy

- Breaking changes require a MAJOR version bump.
- Add a deprecation notice one minor version before removing anything.
- Document breaking changes in `CHANGELOG.md`.

## Commit Messages

Use conventional commits: `feat:`, `fix:`, `docs:`, `test:`, `chore:`, `refactor:`.
