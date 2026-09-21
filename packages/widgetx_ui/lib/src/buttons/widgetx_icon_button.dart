import 'package:flutter/material.dart';
import '../foundations/motion/widgetx_motion.dart';

/// Icon button variant.
enum WidgetXIconButtonVariant {
  /// Standard icon button.
  standard,

  /// Filled background.
  filled,

  /// Outlined border.
  outlined,

  /// Tonal filled.
  tonal,
}

/// A standalone icon button following the WidgetX design system.
///
/// Example:
/// ```dart
/// WidgetXIconButton(
///   icon: Icons.favorite,
///   onPressed: () {},
///   semanticLabel: 'Add to favourites',
/// )
/// ```
class WidgetXIconButton extends StatelessWidget {
  /// Creates a [WidgetXIconButton].
  const WidgetXIconButton({
    super.key,
    required this.icon,
    required this.semanticLabel,
    this.onPressed,
    this.variant = WidgetXIconButtonVariant.standard,
    this.size = 24.0,
    this.isSelected = false,
    this.selectedIcon,
    this.tooltip,
  });

  /// The icon to display.
  final IconData icon;

  /// Accessibility label — always required.
  final String semanticLabel;

  /// Called when tapped. Null disables the button.
  final VoidCallback? onPressed;

  /// Visual variant.
  final WidgetXIconButtonVariant variant;

  /// Icon size in logical pixels.
  final double size;

  /// Whether the button is in a selected/active state.
  final bool isSelected;

  /// Optional icon to show when [isSelected] is true.
  final IconData? selectedIcon;

  /// Optional tooltip text.
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final displayIcon =
        isSelected && selectedIcon != null ? selectedIcon! : icon;

    Widget button;
    switch (variant) {
      case WidgetXIconButtonVariant.standard:
        button = IconButton(
          icon: Icon(displayIcon),
          onPressed: onPressed,
          iconSize: size,
          color: isSelected ? cs.primary : cs.onSurfaceVariant,
          tooltip: tooltip,
        );
      case WidgetXIconButtonVariant.filled:
        button = IconButton.filled(
          icon: Icon(displayIcon),
          onPressed: onPressed,
          iconSize: size,
          tooltip: tooltip,
        );
      case WidgetXIconButtonVariant.outlined:
        button = IconButton.outlined(
          icon: Icon(displayIcon),
          onPressed: onPressed,
          iconSize: size,
          tooltip: tooltip,
        );
      case WidgetXIconButtonVariant.tonal:
        button = IconButton.filledTonal(
          icon: Icon(displayIcon),
          onPressed: onPressed,
          iconSize: size,
          tooltip: tooltip,
        );
    }

    return Semantics(
      button: true,
      label: semanticLabel,
      enabled: onPressed != null,
      child: AnimatedSwitcher(
        duration: WidgetXMotion.fast,
        child: button,
      ),
    );
  }
}
