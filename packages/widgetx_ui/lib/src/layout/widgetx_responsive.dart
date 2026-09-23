import 'package:flutter/material.dart';
import '../foundations/breakpoints/widgetx_breakpoints.dart';

/// Describes the current device screen class.
enum WidgetXScreenSize { mobile, tablet, desktop, widescreen }

/// Returns the [WidgetXScreenSize] for the given [width].
WidgetXScreenSize widgetXScreenSizeOf(
  double width, {
  WidgetXBreakpointConfig config = const WidgetXBreakpointConfig(),
}) {
  if (width >= config.widescreen) return WidgetXScreenSize.widescreen;
  if (width >= config.desktop) return WidgetXScreenSize.desktop;
  if (width >= config.tablet) return WidgetXScreenSize.tablet;
  return WidgetXScreenSize.mobile;
}

/// Builds different layouts depending on the current screen width.
///
/// Example:
/// ```dart
/// WidgetXResponsive(
///   mobile: MobileLayout(),
///   tablet: TabletLayout(),
///   desktop: DesktopLayout(),
/// )
/// ```
class WidgetXResponsive extends StatelessWidget {
  const WidgetXResponsive({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.widescreen,
    this.config = const WidgetXBreakpointConfig(),
  });

  /// Widget shown on mobile screens.
  final Widget mobile;

  /// Widget shown on tablet screens. Falls back to [mobile] if null.
  final Widget? tablet;

  /// Widget shown on desktop screens. Falls back to [tablet] then [mobile].
  final Widget? desktop;

  /// Widget shown on widescreen. Falls back to [desktop] then [tablet] then [mobile].
  final Widget? widescreen;

  /// Configurable breakpoint thresholds.
  final WidgetXBreakpointConfig config;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final size = widgetXScreenSizeOf(width, config: config);

    return switch (size) {
      WidgetXScreenSize.widescreen => widescreen ?? desktop ?? tablet ?? mobile,
      WidgetXScreenSize.desktop => desktop ?? tablet ?? mobile,
      WidgetXScreenSize.tablet => tablet ?? mobile,
      WidgetXScreenSize.mobile => mobile,
    };
  }
}

/// A builder that exposes the current [WidgetXScreenSize].
class WidgetXResponsiveBuilder extends StatelessWidget {
  const WidgetXResponsiveBuilder({
    super.key,
    required this.builder,
    this.config = const WidgetXBreakpointConfig(),
  });

  final Widget Function(BuildContext, WidgetXScreenSize) builder;
  final WidgetXBreakpointConfig config;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final size = widgetXScreenSizeOf(width, config: config);
    return builder(context, size);
  }
}

/// A container with a max width that adapts to the screen size.
class WidgetXResponsiveContainer extends StatelessWidget {
  const WidgetXResponsiveContainer({
    super.key,
    required this.child,
    this.mobileMaxWidth = double.infinity,
    this.tabletMaxWidth = 720,
    this.desktopMaxWidth = 1080,
    this.padding,
    this.config = const WidgetXBreakpointConfig(),
  });

  final Widget child;
  final double mobileMaxWidth;
  final double tabletMaxWidth;
  final double desktopMaxWidth;
  final EdgeInsetsGeometry? padding;
  final WidgetXBreakpointConfig config;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final size = widgetXScreenSizeOf(width, config: config);

    final maxWidth = switch (size) {
      WidgetXScreenSize.mobile => mobileMaxWidth,
      WidgetXScreenSize.tablet => tabletMaxWidth,
      WidgetXScreenSize.desktop ||
      WidgetXScreenSize.widescreen =>
        desktopMaxWidth,
    };

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}
