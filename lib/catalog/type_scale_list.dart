import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

class TypeScaleList extends StatelessWidget {
  const TypeScaleList({super.key});

  static const _styles = [
    _TypeStyle('Display Large', 57),
    _TypeStyle('Display Medium', 45),
    _TypeStyle('Headline Large', 32),
    _TypeStyle('Headline Medium', 28),
    _TypeStyle('Title Large', 22),
    _TypeStyle('Title Medium', 16),
    _TypeStyle('Body Large', 16),
    _TypeStyle('Body Medium', 14),
    _TypeStyle('Label Large', 14),
    _TypeStyle('Label Medium', 12),
    _TypeStyle('Caption', 11),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final style in _styles) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(style.name),
              const SizedBox(width: WidgetXSpacing.sm),
              Text(
                '${style.size}px',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const WidgetXDivider(),
        ],
      ],
    );
  }
}

class _TypeStyle {
  const _TypeStyle(this.name, this.size);
  final String name;
  final int size;
}
