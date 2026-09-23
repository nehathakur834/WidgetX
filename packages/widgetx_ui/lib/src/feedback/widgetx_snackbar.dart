import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';

/// Snackbar severity variant.
enum WidgetXSnackbarVariant { info, success, warning, error }

/// Shows a styled floating snackbar.
///
/// Example:
/// ```dart
/// showWidgetXSnackbar(
///   context: context,
///   message: 'Item saved',
///   variant: WidgetXSnackbarVariant.success,
/// );
/// ```
void showWidgetXSnackbar({
  required BuildContext context,
  required String message,
  WidgetXSnackbarVariant variant = WidgetXSnackbarVariant.info,
  String? actionLabel,
  VoidCallback? onAction,
  Duration duration = const Duration(seconds: 3),
}) {
  final cs = Theme.of(context).colorScheme;

  final (bg, fg, icon) = switch (variant) {
    WidgetXSnackbarVariant.success => (
        const Color(0xFF10B981),
        Colors.white,
        Icons.check_circle_outline
      ),
    WidgetXSnackbarVariant.warning => (
        const Color(0xFFF59E0B),
        Colors.white,
        Icons.warning_amber_rounded
      ),
    WidgetXSnackbarVariant.error => (cs.error, cs.onError, Icons.error_outline),
    WidgetXSnackbarVariant.info => (
        cs.inverseSurface,
        cs.onInverseSurface,
        Icons.info_outline
      ),
  };

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: duration,
      backgroundColor: bg,
      content: Row(
        children: [
          Icon(icon, color: fg, size: 20),
          const SizedBox(width: WidgetXSpacing.sm),
          Expanded(
            child: Text(
              message,
              style:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(color: fg),
            ),
          ),
        ],
      ),
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: fg,
              onPressed: onAction ?? () {},
            )
          : null,
    ),
  );
}
