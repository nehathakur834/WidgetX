import 'package:flutter/material.dart';
import '../foundations/motion/widgetx_motion.dart';
import '../foundations/spacing/widgetx_spacing.dart';

/// Button variant options.
enum WidgetXButtonVariant {
  /// Filled, high-emphasis action.
  primary,

  /// Tonal secondary action.
  secondary,

  /// Outlined, medium-emphasis action.
  outlined,

  /// Text-only, low-emphasis action.
  text,

  /// Destructive / dangerous action.
  destructive,
}

/// Button size options.
enum WidgetXButtonSize {
  /// 36px height.
  small,

  /// 44px height.
  medium,

  /// 52px height.
  large,
}

/// A configurable button widget that follows the WidgetX design system.
///
/// Example:
/// ```dart
/// WidgetXButton(
///   label: 'Continue',
///   variant: WidgetXButtonVariant.primary,
///   onPressed: () {},
/// )
/// ```
class WidgetXButton extends StatelessWidget {
  /// Creates a [WidgetXButton].
  const WidgetXButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = WidgetXButtonVariant.primary,
    this.size = WidgetXButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.semanticLabel,
  });

  /// Button label text.
  final String label;

  /// Called when the button is tapped. Set to null to disable.
  final VoidCallback? onPressed;

  /// Visual style variant.
  final WidgetXButtonVariant variant;

  /// Size variant.
  final WidgetXButtonSize size;

  /// Optional icon shown before the label.
  final Widget? leadingIcon;

  /// Optional icon shown after the label.
  final Widget? trailingIcon;

  /// Shows a loading indicator and disables interaction.
  final bool isLoading;

  /// Expands button to fill its parent's width.
  final bool isFullWidth;

  /// Overrides the default accessibility label.
  final String? semanticLabel;

  double get _height {
    switch (size) {
      case WidgetXButtonSize.small:
        return 36;
      case WidgetXButtonSize.medium:
        return 44;
      case WidgetXButtonSize.large:
        return 52;
    }
  }

  EdgeInsetsGeometry get _padding {
    switch (size) {
      case WidgetXButtonSize.small:
        return const EdgeInsets.symmetric(
            horizontal: WidgetXSpacing.sm, vertical: WidgetXSpacing.xs);
      case WidgetXButtonSize.medium:
        return const EdgeInsets.symmetric(
            horizontal: WidgetXSpacing.md, vertical: WidgetXSpacing.sm);
      case WidgetXButtonSize.large:
        return const EdgeInsets.symmetric(
            horizontal: WidgetXSpacing.lg, vertical: WidgetXSpacing.sm + 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDisabled = onPressed == null || isLoading;

    final child = _ButtonContent(
      label: label,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      isLoading: isLoading,
      variant: variant,
      isDisabled: isDisabled,
    );

    final style = _buildStyle(colorScheme, isDisabled);

    Widget button;
    switch (variant) {
      case WidgetXButtonVariant.primary:
      case WidgetXButtonVariant.secondary:
      case WidgetXButtonVariant.destructive:
        button = ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: child,
        );
      case WidgetXButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: child,
        );
      case WidgetXButtonVariant.text:
        button = TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: child,
        );
    }

    if (isFullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return Semantics(
      button: true,
      label: semanticLabel ?? label,
      enabled: !isDisabled,
      child: button,
    );
  }

  ButtonStyle _buildStyle(ColorScheme cs, bool isDisabled) {
    Color bg;
    Color fg;
    BorderSide? side;

    switch (variant) {
      case WidgetXButtonVariant.primary:
        bg = isDisabled ? cs.onSurface.withValues(alpha: 0.12) : cs.primary;
        fg = isDisabled ? cs.onSurface.withValues(alpha: 0.38) : cs.onPrimary;
      case WidgetXButtonVariant.secondary:
        bg = isDisabled
            ? cs.onSurface.withValues(alpha: 0.12)
            : cs.secondaryContainer;
        fg = isDisabled
            ? cs.onSurface.withValues(alpha: 0.38)
            : cs.onSecondaryContainer;
      case WidgetXButtonVariant.destructive:
        bg = isDisabled ? cs.onSurface.withValues(alpha: 0.12) : cs.error;
        fg = isDisabled ? cs.onSurface.withValues(alpha: 0.38) : cs.onError;
      case WidgetXButtonVariant.outlined:
        bg = Colors.transparent;
        fg = isDisabled ? cs.onSurface.withValues(alpha: 0.38) : cs.primary;
        side = BorderSide(
          color: isDisabled ? cs.onSurface.withValues(alpha: 0.12) : cs.primary,
        );
      case WidgetXButtonVariant.text:
        bg = Colors.transparent;
        fg = isDisabled ? cs.onSurface.withValues(alpha: 0.38) : cs.primary;
    }

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(bg),
      foregroundColor: WidgetStateProperty.all(fg),
      side: side != null ? WidgetStateProperty.all(side) : null,
      elevation: WidgetStateProperty.all(0),
      minimumSize: WidgetStateProperty.all(Size(0, _height)),
      padding: WidgetStateProperty.all(_padding),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      animationDuration: WidgetXMotion.normal,
    );
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.variant,
    required this.isDisabled,
    required this.isLoading,
    this.leadingIcon,
    this.trailingIcon,
  });

  final String label;
  final WidgetXButtonVariant variant;
  final bool isDisabled;
  final bool isLoading;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leadingIcon != null) ...[
          leadingIcon!,
          const SizedBox(width: WidgetXSpacing.xs),
        ],
        Text(label),
        if (trailingIcon != null) ...[
          const SizedBox(width: WidgetXSpacing.xs),
          trailingIcon!,
        ],
      ],
    );
  }
}
