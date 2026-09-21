import 'package:flutter/material.dart';

/// A labeled toggle switch following the WidgetX design system.
///
/// Example:
/// ```dart
/// WidgetXSwitch(
///   label: 'Enable notifications',
///   value: _enabled,
///   onChanged: (v) => setState(() => _enabled = v),
/// )
/// ```
class WidgetXSwitch extends StatelessWidget {
  const WidgetXSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.isEnabled = true,
    this.helperText,
    this.semanticLabel,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isEnabled;
  final String? helperText;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      toggled: value,
      label: semanticLabel ?? label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isEnabled
                        ? theme.colorScheme.onSurface
                        : theme.colorScheme.onSurface.withValues(alpha: 0.38),
                  ),
                ),
              ),
              Switch(
                value: value,
                onChanged: isEnabled ? onChanged : null,
              ),
            ],
          ),
          if (helperText != null)
            Text(
              helperText!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }
}
