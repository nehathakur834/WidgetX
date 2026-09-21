import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';

/// Banner severity variant.
enum WidgetXBannerVariant { info, success, warning, error }

/// A non-dismissible status banner for persistent messages.
///
/// Example:
/// ```dart
/// WidgetXBanner(
///   variant: WidgetXBannerVariant.warning,
///   message: 'Your session will expire soon.',
/// )
/// ```
class WidgetXBanner extends StatelessWidget {
  const WidgetXBanner({
    super.key,
    required this.message,
    this.variant = WidgetXBannerVariant.info,
    this.action,
    this.onDismiss,
    this.title,
    this.semanticLabel,
  });

  final String message;
  final WidgetXBannerVariant variant;
  final Widget? action;
  final VoidCallback? onDismiss;
  final String? title;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final (bg, border, icon, fg) = switch (variant) {
      WidgetXBannerVariant.success => (
          const Color(0xFFD1FAE5),
          const Color(0xFF10B981),
          Icons.check_circle_outline,
          const Color(0xFF065F46),
        ),
      WidgetXBannerVariant.warning => (
          const Color(0xFFFEF3C7),
          const Color(0xFFF59E0B),
          Icons.warning_amber_rounded,
          const Color(0xFF92400E),
        ),
      WidgetXBannerVariant.error => (
          const Color(0xFFFEE2E2),
          const Color(0xFFEF4444),
          Icons.error_outline,
          const Color(0xFF7F1D1D),
        ),
      WidgetXBannerVariant.info => (
          const Color(0xFFDBEAFE),
          const Color(0xFF3B82F6),
          Icons.info_outline,
          const Color(0xFF1E3A5F),
        ),
    };

    return Semantics(
      label: semanticLabel ?? '${variant.name}: $message',
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.all(WidgetXSpacing.md),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: fg, size: 20),
            const SizedBox(width: WidgetXSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: fg),
                    ),
                  Text(
                    message,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: fg),
                  ),
                  if (action != null) ...[
                    const SizedBox(height: WidgetXSpacing.sm),
                    action!,
                  ],
                ],
              ),
            ),
            if (onDismiss != null)
              IconButton(
                icon: Icon(Icons.close, color: fg, size: 18),
                onPressed: onDismiss,
                tooltip: 'Dismiss',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
          ],
        ),
      ),
    );
  }
}
