import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';

/// A labeled radio button following the WidgetX design system.
///
/// Wrap a column of [WidgetXRadio] widgets inside Flutter's native
/// [RadioListTileGroup] or use the standalone [WidgetXRadioGroup] helper.
///
/// Example:
/// ```dart
/// WidgetXRadioGroup<String>(
///   groupValue: _selected,
///   onChanged: (v) => setState(() => _selected = v!),
///   children: const [
///     WidgetXRadio<String>(label: 'Option A', value: 'option_a'),
///     WidgetXRadio<String>(label: 'Option B', value: 'option_b'),
///   ],
/// )
/// ```
class WidgetXRadioGroup<T> extends StatelessWidget {
  const WidgetXRadioGroup({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.children,
  });

  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final List<WidgetXRadio<T>> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
          .map(
            (r) => _WidgetXRadioItem<T>(
              label: r.label,
              value: r.value,
              groupValue: groupValue,
              onChanged: onChanged,
              isEnabled: r.isEnabled,
              semanticLabel: r.semanticLabel,
            ),
          )
          .toList(),
    );
  }
}

/// Declarative data holder for a radio option.
class WidgetXRadio<T> {
  const WidgetXRadio({
    required this.label,
    required this.value,
    this.isEnabled = true,
    this.semanticLabel,
  });

  final String label;
  final T value;
  final bool isEnabled;
  final String? semanticLabel;
}

class _WidgetXRadioItem<T> extends StatelessWidget {
  const _WidgetXRadioItem({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.isEnabled,
    this.semanticLabel,
  });

  final String label;
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final bool isEnabled;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = groupValue == value;

    return Semantics(
      inMutuallyExclusiveGroup: true,
      label: semanticLabel ?? label,
      selected: isSelected,
      child: InkWell(
        onTap: isEnabled ? () => onChanged(value) : null,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: WidgetXSpacing.xs,
            vertical: WidgetXSpacing.xs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Use a simple visual-only radio circle to avoid deprecated API
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: WidgetXSpacing.sm),
              Flexible(
                child: Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isEnabled
                        ? theme.colorScheme.onSurface
                        : theme.colorScheme.onSurface
                            .withValues(alpha: 0.38),
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
