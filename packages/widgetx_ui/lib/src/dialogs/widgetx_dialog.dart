import 'package:flutter/material.dart';
import '../foundations/motion/widgetx_motion.dart';

/// Shows a WidgetX-styled alert dialog.
///
/// Returns the result of the dismissed dialog (true = confirmed, false/null = cancelled).
Future<bool?> showWidgetXAlertDialog({
  required BuildContext context,
  required String title,
  required String message,
  String confirmLabel = 'OK',
  String? cancelLabel,
  bool isDismissible = true,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: isDismissible,
    builder: (ctx) => _WidgetXAlertDialog(
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
    ),
  );
}

/// Shows a WidgetX-styled confirmation dialog.
Future<bool?> showWidgetXConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  String confirmLabel = 'Confirm',
  String cancelLabel = 'Cancel',
  bool isDestructive = false,
  bool isDismissible = true,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: isDismissible,
    builder: (ctx) => _WidgetXAlertDialog(
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      isDestructive: isDestructive,
    ),
  );
}

class _WidgetXAlertDialog extends StatelessWidget {
  const _WidgetXAlertDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    this.cancelLabel,
    this.isDestructive = false,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String? cancelLabel;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        if (cancelLabel != null)
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelLabel!),
          ),
        FilledButton(
          style: isDestructive
              ? FilledButton.styleFrom(backgroundColor: cs.error)
              : null,
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}

/// A generic dialog that accepts a custom [body] widget.
class WidgetXDialog extends StatelessWidget {
  const WidgetXDialog({
    super.key,
    required this.title,
    required this.body,
    this.actions = const [],
    this.isDismissible = true,
    this.padding,
  });

  final String title;
  final Widget body;
  final List<Widget> actions;
  final bool isDismissible;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: body,
        ),
      ),
      actions: actions,
    );
  }

  /// Shows this dialog.
  Future<T?> show<T>(BuildContext context) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: isDismissible,
      barrierLabel: title,
      transitionDuration: WidgetXMotion.normal,
      transitionBuilder: (ctx, anim, _, child) => ScaleTransition(
        scale: CurvedAnimation(parent: anim, curve: WidgetXMotion.decelerate),
        child: FadeTransition(opacity: anim, child: child),
      ),
      pageBuilder: (ctx, _, __) => this,
    );
  }
}
