/// Responsive breakpoint tokens for WidgetX UI.
///
/// Breakpoints follow a mobile-first approach.
/// Values are configurable via [WidgetXBreakpointConfig].
abstract final class WidgetXBreakpoints {
  /// Mobile: 0–599px.
  static const double mobile = 0;

  /// Tablet: 600–1023px.
  static const double tablet = 600;

  /// Desktop: 1024px+.
  static const double desktop = 1024;

  /// Large desktop: 1440px+.
  static const double widescreen = 1440;
}

/// Configurable breakpoint thresholds.
class WidgetXBreakpointConfig {
  /// Creates a [WidgetXBreakpointConfig] with optional overrides.
  const WidgetXBreakpointConfig({
    this.tablet = WidgetXBreakpoints.tablet,
    this.desktop = WidgetXBreakpoints.desktop,
    this.widescreen = WidgetXBreakpoints.widescreen,
  });

  /// Minimum width for tablet layout.
  final double tablet;

  /// Minimum width for desktop layout.
  final double desktop;

  /// Minimum width for widescreen layout.
  final double widescreen;
}
