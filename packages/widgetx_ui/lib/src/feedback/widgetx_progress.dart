import 'package:flutter/material.dart';

/// A WidgetX-styled circular progress indicator.
class WidgetXCircularProgress extends StatelessWidget {
  const WidgetXCircularProgress({
    super.key,
    this.value,
    this.size = 36.0,
    this.strokeWidth = 3.0,
    this.color,
    this.semanticLabel = 'Loading',
  });

  /// Null for indeterminate.
  final double? value;
  final double size;
  final double strokeWidth;
  final Color? color;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          value: value,
          strokeWidth: strokeWidth,
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

/// A WidgetX-styled linear progress indicator.
class WidgetXLinearProgress extends StatelessWidget {
  const WidgetXLinearProgress({
    super.key,
    this.value,
    this.minHeight = 4.0,
    this.color,
    this.backgroundColor,
    this.semanticLabel = 'Loading',
    this.borderRadius,
  });

  /// Null for indeterminate.
  final double? value;
  final double minHeight;
  final Color? color;
  final Color? backgroundColor;
  final String semanticLabel;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Semantics(
      label: semanticLabel,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(minHeight / 2),
        child: LinearProgressIndicator(
          value: value,
          minHeight: minHeight,
          color: color ?? cs.primary,
          backgroundColor: backgroundColor ?? cs.surfaceContainerHighest,
        ),
      ),
    );
  }
}
