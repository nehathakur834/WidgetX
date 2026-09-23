import 'package:flutter/material.dart';
import '../foundations/motion/widgetx_motion.dart';

/// FAB size variant.
enum WidgetXFABSize {
  /// Small FAB — 40px.
  small,

  /// Regular FAB — 56px.
  regular,

  /// Large FAB — 96px.
  large,
}

/// A WidgetX-styled Floating Action Button.
///
/// Example:
/// ```dart
/// WidgetXFAB(
///   icon: Icons.add,
///   onPressed: () {},
///   label: 'New Item',
/// )
/// ```
class WidgetXFAB extends StatelessWidget {
  /// Creates a [WidgetXFAB].
  const WidgetXFAB({
    super.key,
    required this.icon,
    required this.onPressed,
    this.label,
    this.size = WidgetXFABSize.regular,
    this.semanticLabel,
    this.backgroundColor,
    this.foregroundColor,
    this.heroTag,
  });

  /// Icon to display inside the FAB.
  final IconData icon;

  /// Called when the FAB is tapped.
  final VoidCallback? onPressed;

  /// Optional text label — if set, renders an extended FAB.
  final String? label;

  /// Size variant.
  final WidgetXFABSize size;

  /// Accessibility label for the FAB.
  final String? semanticLabel;

  /// Optional background color override.
  final Color? backgroundColor;

  /// Optional foreground color override.
  final Color? foregroundColor;

  /// Hero tag for the FAB. Defaults to [null], which disables the hero
  /// animation. Set to a unique value when using a single FAB as a
  /// [Scaffold.floatingActionButton].
  final Object? heroTag;

  double get _iconSize => switch (size) {
        WidgetXFABSize.small => 18,
        WidgetXFABSize.regular => 24,
        WidgetXFABSize.large => 36,
      };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = backgroundColor ?? cs.primaryContainer;
    final fg = foregroundColor ?? cs.onPrimaryContainer;

    final iconWidget = Icon(icon, size: _iconSize, color: fg);

    Widget fab;
    if (label != null && label!.isNotEmpty) {
      // Extended FAB
      fab = FloatingActionButton.extended(
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: bg,
        foregroundColor: fg,
        elevation: 2,
        icon: iconWidget,
        label: Text(label!, style: TextStyle(color: fg)),
      );
    } else if (size == WidgetXFABSize.small) {
      fab = FloatingActionButton.small(
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: bg,
        foregroundColor: fg,
        elevation: 2,
        child: iconWidget,
      );
    } else if (size == WidgetXFABSize.large) {
      fab = FloatingActionButton.large(
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: bg,
        foregroundColor: fg,
        elevation: 2,
        child: iconWidget,
      );
    } else {
      fab = FloatingActionButton(
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: bg,
        foregroundColor: fg,
        elevation: 2,
        child: iconWidget,
      );
    }

    return Semantics(
      label: semanticLabel ?? label ?? 'Action button',
      button: true,
      child: AnimatedScale(
        scale: onPressed != null ? 1.0 : 0.9,
        duration: WidgetXMotion.normal,
        child: fab,
      ),
    );
  }
}
