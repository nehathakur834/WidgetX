import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';

/// Displays an empty or error state with an icon, title, and optional action.
///
/// Example:
/// ```dart
/// WidgetXEmptyState(
///   icon: Icons.inbox_outlined,
///   title: 'Nothing here yet',
///   description: 'Add your first item to get started.',
///   action: WidgetXButton(label: 'Add item', onPressed: () {}),
/// )
/// ```
class WidgetXEmptyState extends StatelessWidget {
  const WidgetXEmptyState({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.illustration,
    this.action,
    this.isError = false,
    this.semanticLabel,
  });

  final String title;
  final String? description;
  final IconData? icon;
  final Widget? illustration;
  final Widget? action;
  final bool isError;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final iconColor = isError ? cs.error : cs.onSurfaceVariant;
    final effectiveIcon =
        icon ?? (isError ? Icons.error_outline : Icons.inbox_outlined);

    return Semantics(
      label: semanticLabel ?? title,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(WidgetXSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (illustration != null) ...[
                illustration!,
                const SizedBox(height: WidgetXSpacing.lg),
              ] else ...[
                Icon(effectiveIcon, size: 64, color: iconColor),
                const SizedBox(height: WidgetXSpacing.md),
              ],
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              if (description != null) ...[
                const SizedBox(height: WidgetXSpacing.xs),
                Text(
                  description!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (action != null) ...[
                const SizedBox(height: WidgetXSpacing.lg),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
