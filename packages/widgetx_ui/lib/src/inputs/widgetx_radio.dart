import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';

/// A labeled radio button following the WidgetX design system.
///
/// Example:
/// ```dart
/// RadioGroup<String>(
///   groupValue: _selected,
///   onChanged: (v) => setState(() => _selected = v),
///   child: Column(
///     children: [
///       WidgetXRadio<String>(label: 'Option A', value: 'a'),
///       WidgetXRadio<String>(label: 'Option B', value: 'b'),
///     ],
///   ),
/// )
/// ```
class WidgetXRadio<T> extends StatelessWidget {
  const WidgetXRadio({
    super.key,
    required this.label,
    required this.value,
    this.isEnabled = true,
    this.semanticLabel,
  });

  final String label;
  final T value;
  final bool isEnabled;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      inMutuallyExclusiveGroup: true,
      label: semanticLabel ?? label,
      child: InkWell(
        onTap: isEnabled
            ? () {
                final state = RadioGroup.maybeOf<T>(context);
                if (state != null) {
                  state.onChanged.call(value);
                }
              }
            : null,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: WidgetXSpacing.xs, vertical: WidgetXSpacing.xs),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<T>(
                value: value,
              ),
              const SizedBox(width: WidgetXSpacing.xs),
              Flexible(
                child: Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isEnabled
                        ? theme.colorScheme.onSurface
                        : theme.colorScheme.onSurface.withValues(alpha: 0.38),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
