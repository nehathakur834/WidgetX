import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';

/// A labeled checkbox following the WidgetX design system.
///
/// Example:
/// ```dart
/// WidgetXCheckbox(
///   label: 'Accept terms',
///   value: _accepted,
///   onChanged: (v) => setState(() => _accepted = v ?? false),
/// )
/// ```
class WidgetXCheckbox extends StatelessWidget {
  const WidgetXCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.isEnabled = true,
    this.helperText,
    this.errorText,
    this.semanticLabel,
    this.tristate = false,
  });

  final String label;
  final bool? value;
  final ValueChanged<bool?> onChanged;
  final bool isEnabled;
  final String? helperText;
  final String? errorText;
  final String? semanticLabel;
  final bool tristate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      checked: value ?? false,
      label: semanticLabel ?? label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: isEnabled
                ? () => onChanged(tristate
                    ? (value == null ? true : (value! ? null : false))
                    : !(value ?? false))
                : null,
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: WidgetXSpacing.xs, vertical: WidgetXSpacing.xs),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: value,
                    tristate: tristate,
                    onChanged: isEnabled ? onChanged : null,
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
          if (helperText != null && errorText == null)
            Padding(
              padding: const EdgeInsets.only(left: WidgetXSpacing.lg),
              child: Text(
                helperText!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(left: WidgetXSpacing.lg),
              child: Text(
                errorText!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
