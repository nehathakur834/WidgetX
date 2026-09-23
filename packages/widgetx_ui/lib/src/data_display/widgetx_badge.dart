import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';

/// Badge visual variant.
enum WidgetXBadgeVariant {
  primary,
  secondary,
  success,
  warning,
  error,
  info,
  neutral,
}

/// A small status/count badge following the WidgetX design system.
///
/// Example:
/// ```dart
/// WidgetXBadge(label: '3', variant: WidgetXBadgeVariant.error)
/// ```
class WidgetXBadge extends StatelessWidget {
  const WidgetXBadge({
    super.key,
    required this.label,
    this.variant = WidgetXBadgeVariant.primary,
    this.semanticLabel,
  });

  final String label;
  final WidgetXBadgeVariant variant;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final (bg, fg) = switch (variant) {
      WidgetXBadgeVariant.primary => (cs.primary, cs.onPrimary),
      WidgetXBadgeVariant.secondary => (
          cs.secondaryContainer,
          cs.onSecondaryContainer
        ),
      WidgetXBadgeVariant.success => (const Color(0xFF10B981), Colors.white),
      WidgetXBadgeVariant.warning => (const Color(0xFFF59E0B), Colors.white),
      WidgetXBadgeVariant.error => (cs.error, cs.onError),
      WidgetXBadgeVariant.info => (const Color(0xFF3B82F6), Colors.white),
      WidgetXBadgeVariant.neutral => (
          cs.surfaceContainerHighest,
          cs.onSurfaceVariant
        ),
    };

    return Semantics(
      label: semanticLabel ?? 'Badge: $label',
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: WidgetXSpacing.sm, vertical: WidgetXSpacing.xxs),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: fg, height: 1),
        ),
      ),
    );
  }
}

/// Wraps a [child] with a small dot or count overlay badge.
class WidgetXOverlayBadge extends StatelessWidget {
  const WidgetXOverlayBadge({
    super.key,
    required this.child,
    this.count,
    this.showDot = false,
    this.color,
    this.semanticLabel,
  }) : assert(
            count != null || showDot, 'Provide either count or showDot = true');

  final Widget child;
  final int? count;
  final bool showDot;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final badgeColor = color ?? cs.error;

    return Semantics(
      label: semanticLabel,
      child: Badge(
        label: showDot ? null : Text('${count ?? 0}'),
        backgroundColor: badgeColor,
        isLabelVisible: showDot || (count != null && count! > 0),
        child: child,
      ),
    );
  }
}
