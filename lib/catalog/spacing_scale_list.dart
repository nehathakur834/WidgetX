import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

class SpacingScaleList extends StatelessWidget {
  const SpacingScaleList({super.key});

  static const _scale = [
    _SpacingToken('xxs', WidgetXSpacing.xxs),
    _SpacingToken('xs', WidgetXSpacing.xs),
    _SpacingToken('sm', WidgetXSpacing.sm),
    _SpacingToken('md', WidgetXSpacing.md),
    _SpacingToken('lg', WidgetXSpacing.lg),
    _SpacingToken('xl', WidgetXSpacing.xl),
    _SpacingToken('xxl', WidgetXSpacing.xxl),
    _SpacingToken('xxxl', WidgetXSpacing.xxxl),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _scale
          .map(
            (t) => Padding(
              padding: const EdgeInsets.symmetric(vertical: WidgetXSpacing.xxs),
              child: Row(
                children: [
                  SizedBox(
                    width: 48,
                    child: Text(
                      t.name,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  Container(
                    width: t.value * 1.5,
                    height: 20,
                    decoration: BoxDecoration(
                      color: cs.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: WidgetXSpacing.sm),
                  Text(
                    '${t.value.toInt()}px',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SpacingToken {
  const _SpacingToken(this.name, this.value);
  final String name;
  final double value;
}
