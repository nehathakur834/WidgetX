import 'package:flutter/material.dart';

/// A single-select dropdown following the WidgetX design system.
///
/// Example:
/// ```dart
/// WidgetXDropdown<String>(
///   label: 'Country',
///   value: _country,
///   items: ['US', 'UK', 'AU'],
///   itemLabel: (v) => v,
///   onChanged: (v) => setState(() => _country = v),
/// )
/// ```
class WidgetXDropdown<T> extends StatelessWidget {
  const WidgetXDropdown({
    super.key,
    required this.items,
    required this.itemLabel,
    this.value,
    this.onChanged,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.isEnabled = true,
    this.semanticLabel,
    this.prefixIcon,
  });

  final List<T> items;
  final String Function(T) itemLabel;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final bool isEnabled;
  final String? semanticLabel;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? label,
      child: DropdownButtonFormField<T>(
        initialValue: value,
        onChanged: isEnabled ? onChanged : null,
        items: items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(itemLabel(item)),
              ),
            )
            .toList(),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          helperText: helperText,
          errorText: errorText,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
