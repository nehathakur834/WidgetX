import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';

/// A WidgetX-styled horizontal or vertical divider.
///
/// Example:
/// ```dart
/// WidgetXDivider()
/// WidgetXDivider.vertical(height: 24)
/// WidgetXDivider.labeled(label: 'or')
/// ```
class WidgetXDivider extends StatelessWidget {
  /// Creates a horizontal divider.
  const WidgetXDivider({
    super.key,
    this.indent,
    this.endIndent,
    this.thickness = 1,
    this.color,
  })  : _isVertical = false,
        _label = null,
        _width = null;

  /// Creates a vertical divider.
  const WidgetXDivider.vertical({
    super.key,
    this.thickness = 1,
    this.color,
    double? width,
  })  : _isVertical = true,
        _label = null,
        _width = width,
        indent = null,
        endIndent = null;

  /// Creates a horizontal divider with a centered text label.
  const WidgetXDivider.labeled({
    super.key,
    required String label,
    this.color,
  })  : _isVertical = false,
        _label = label,
        thickness = 1,
        indent = null,
        endIndent = null,
        _width = null;

  final double? indent;
  final double? endIndent;
  final double thickness;
  final Color? color;
  final bool _isVertical;
  final String? _label;
  final double? _width;

  @override
  Widget build(BuildContext context) {
    final dividerColor = color ?? Theme.of(context).colorScheme.outlineVariant;

    if (_isVertical) {
      return VerticalDivider(
        thickness: thickness,
        color: dividerColor,
        width: _width,
      );
    }

    if (_label != null) {
      return Row(
        children: [
          Expanded(child: Divider(color: dividerColor, thickness: thickness)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: WidgetXSpacing.sm),
            child: Text(
              _label!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          Expanded(child: Divider(color: dividerColor, thickness: thickness)),
        ],
      );
    }

    return Divider(
      indent: indent,
      endIndent: endIndent,
      thickness: thickness,
      color: dividerColor,
    );
  }
}
