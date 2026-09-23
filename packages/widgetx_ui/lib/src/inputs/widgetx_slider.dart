import 'package:flutter/material.dart';

/// A labeled slider following the WidgetX design system.
///
/// Example:
/// ```dart
/// WidgetXSlider(
///   label: 'Volume',
///   value: _volume,
///   onChanged: (v) => setState(() => _volume = v),
/// )
/// ```
class WidgetXSlider extends StatelessWidget {
  const WidgetXSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.isEnabled = true,
    this.semanticLabel,
    this.onChangeEnd,
    this.showValueLabel = false,
  });

  final double value;
  final ValueChanged<double> onChanged;
  final String? label;
  final double min;
  final double max;
  final int? divisions;
  final bool isEnabled;
  final String? semanticLabel;
  final ValueChanged<double>? onChangeEnd;
  final bool showValueLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) Text(label!, style: theme.textTheme.bodyMedium),
        Semantics(
          label: semanticLabel ?? label,
          slider: true,
          value: '${((value - min) / (max - min) * 100).round()}%',
          child: Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            divisions: divisions,
            label: showValueLabel ? value.toStringAsFixed(1) : null,
            onChanged: isEnabled ? onChanged : null,
            onChangeEnd: onChangeEnd,
          ),
        ),
      ],
    );
  }
}
