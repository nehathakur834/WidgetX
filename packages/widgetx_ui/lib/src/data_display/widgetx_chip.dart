import 'package:flutter/material.dart';

/// Chip variant.
enum WidgetXChipVariant { filled, outlined, suggestion }

/// A WidgetX-styled chip.
///
/// Example:
/// ```dart
/// WidgetXChip(label: 'Flutter', onDeleted: () {})
/// ```
class WidgetXChip extends StatelessWidget {
  const WidgetXChip({
    super.key,
    required this.label,
    this.avatar,
    this.onDeleted,
    this.onPressed,
    this.isSelected = false,
    this.isEnabled = true,
    this.variant = WidgetXChipVariant.filled,
    this.semanticLabel,
    this.tooltip,
  });

  final String label;
  final Widget? avatar;
  final VoidCallback? onDeleted;
  final VoidCallback? onPressed;
  final bool isSelected;
  final bool isEnabled;
  final WidgetXChipVariant variant;
  final String? semanticLabel;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    if (onDeleted != null) {
      return InputChip(
        label: Text(label),
        avatar: avatar,
        isEnabled: isEnabled,
        selected: isSelected,
        onPressed: isEnabled ? onPressed : null,
        onDeleted: isEnabled ? onDeleted : null,
        tooltip: tooltip,
      );
    }

    if (isSelected || onPressed != null) {
      return FilterChip(
        label: Text(label),
        avatar: avatar,
        selected: isSelected,
        onSelected: isEnabled ? (_) => onPressed?.call() : null,
        tooltip: tooltip,
      );
    }

    return Chip(
      label: Text(label),
      avatar: avatar,
    );
  }
}
