import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../foundations/motion/widgetx_motion.dart';
import '../foundations/spacing/widgetx_spacing.dart';

/// A one-time password (OTP) input field with individual digit boxes.
///
/// Example:
/// ```dart
/// WidgetXOTPField(
///   length: 6,
///   onCompleted: (otp) => print('OTP: $otp'),
/// )
/// ```
class WidgetXOTPField extends StatefulWidget {
  const WidgetXOTPField({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.isEnabled = true,
    this.obscureText = false,
    this.semanticLabel = 'One-time password',
  });

  /// Number of OTP digits (typically 4 or 6).
  final int length;

  /// Called when all digits are entered.
  final ValueChanged<String>? onCompleted;

  /// Called on every change with the current partial/complete value.
  final ValueChanged<String>? onChanged;

  final bool isEnabled;

  /// Obscure the entered digits.
  final bool obscureText;

  final String semanticLabel;

  @override
  State<WidgetXOTPField> createState() => _WidgetXOTPFieldState();
}

class _WidgetXOTPFieldState extends State<WidgetXOTPField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _currentValue =>
      _controllers.map((c) => c.text).join();

  void _onChanged(int index, String value) {
    if (value.length > 1) {
      // Handle paste
      final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
      for (var i = 0; i < widget.length && i < digits.length; i++) {
        _controllers[i].text = digits[i];
      }
      final focusIndex = (digits.length).clamp(0, widget.length - 1);
      _focusNodes[focusIndex].requestFocus();
    } else if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }
    final current = _currentValue;
    widget.onChanged?.call(current);
    if (current.length == widget.length) {
      widget.onCompleted?.call(current);
    }
  }

  void _onKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < widget.length; i++) ...[
            if (i > 0) const SizedBox(width: WidgetXSpacing.sm),
            _OTPBox(
              controller: _controllers[i],
              focusNode: _focusNodes[i],
              isEnabled: widget.isEnabled,
              obscureText: widget.obscureText,
              onChanged: (v) => _onChanged(i, v),
              onKeyEvent: (e) => _onKeyEvent(i, e),
            ),
          ],
        ],
      ),
    );
  }
}

class _OTPBox extends StatefulWidget {
  const _OTPBox({
    required this.controller,
    required this.focusNode,
    required this.isEnabled,
    required this.obscureText,
    required this.onChanged,
    required this.onKeyEvent,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isEnabled;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final ValueChanged<KeyEvent> onKeyEvent;

  @override
  State<_OTPBox> createState() => _OTPBoxState();
}

class _OTPBoxState extends State<_OTPBox> {
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() => _focused = widget.focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: WidgetXMotion.fast,
      width: 48,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _focused ? cs.primary : cs.outline,
          width: _focused ? 2 : 1,
        ),
        color: cs.surfaceContainerHighest,
      ),
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: widget.onKeyEvent,
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: widget.isEnabled,
          obscureText: widget.obscureText,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: widget.onChanged,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
          decoration: const InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            counterText: '',
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
