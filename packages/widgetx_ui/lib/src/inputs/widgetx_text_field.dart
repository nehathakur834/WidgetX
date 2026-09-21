import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A styled text field following the WidgetX design system.
///
/// Wraps Flutter's [TextFormField] with WidgetX theming, accessibility
/// labels, and consistent error / helper text rendering.
///
/// Example:
/// ```dart
/// WidgetXTextField(
///   label: 'Email',
///   hint: 'you@example.com',
///   controller: _emailController,
///   keyboardType: TextInputType.emailAddress,
/// )
/// ```
class WidgetXTextField extends StatelessWidget {
  /// Creates a [WidgetXTextField].
  const WidgetXTextField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.autofocus = false,
    this.semanticLabel,
    this.initialValue,
  });

  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isEnabled;
  final bool isReadOnly;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool autofocus;
  final String? semanticLabel;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? label,
      textField: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            initialValue: initialValue,
            enabled: isEnabled,
            readOnly: isReadOnly,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            validator: validator,
            maxLines: obscureText ? 1 : maxLines,
            minLines: minLines,
            maxLength: maxLength,
            autofocus: autofocus,
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              helperText: helperText,
              errorText: errorText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              counterText: maxLength != null ? null : '',
            ),
          ),
        ],
      ),
    );
  }
}

/// A password field with visibility toggle.
class WidgetXPasswordField extends StatefulWidget {
  const WidgetXPasswordField({
    super.key,
    this.label = 'Password',
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.validator,
    this.isEnabled = true,
    this.semanticLabel,
  });

  final String label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool isEnabled;
  final String? semanticLabel;

  @override
  State<WidgetXPasswordField> createState() => _WidgetXPasswordFieldState();
}

class _WidgetXPasswordFieldState extends State<WidgetXPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return WidgetXTextField(
      label: widget.label,
      hint: widget.hint,
      helperText: widget.helperText,
      errorText: widget.errorText,
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      validator: widget.validator,
      isEnabled: widget.isEnabled,
      obscureText: _obscure,
      semanticLabel: widget.semanticLabel ?? widget.label,
      suffixIcon: IconButton(
        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => _obscure = !_obscure),
        tooltip: _obscure ? 'Show password' : 'Hide password',
      ),
    );
  }
}

/// A search text field with leading search icon and optional clear button.
class WidgetXSearchField extends StatefulWidget {
  const WidgetXSearchField({
    super.key,
    this.hint = 'Search…',
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.isEnabled = true,
    this.semanticLabel = 'Search',
  });

  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool isEnabled;
  final String semanticLabel;

  @override
  State<WidgetXSearchField> createState() => _WidgetXSearchFieldState();
}

class _WidgetXSearchFieldState extends State<WidgetXSearchField> {
  late final TextEditingController _ctrl;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _ctrl = widget.controller ?? TextEditingController();
    _ctrl.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = _ctrl.text.isNotEmpty;
    if (hasText != _hasText) setState(() => _hasText = hasText);
    widget.onChanged?.call(_ctrl.text);
  }

  @override
  void dispose() {
    if (widget.controller == null) _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetXTextField(
      hint: widget.hint,
      controller: _ctrl,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      isEnabled: widget.isEnabled,
      semanticLabel: widget.semanticLabel,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: _hasText
          ? IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Clear search',
              onPressed: () {
                _ctrl.clear();
                widget.onChanged?.call('');
              },
            )
          : null,
    );
  }
}
