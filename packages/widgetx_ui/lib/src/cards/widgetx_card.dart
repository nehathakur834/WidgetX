import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';
import '../foundations/motion/widgetx_motion.dart';

/// Card visual variant.
enum WidgetXCardVariant {
  /// Default outlined card.
  basic,

  /// Card with a leading info icon strip.
  info,

  /// Card showing a large numeric metric.
  statistic,

  /// Card with a circular avatar, name, and role.
  profile,

  /// Card highlighting a product or item.
  product,

  /// Card with one or more action buttons in the footer.
  action,

  /// Card that expands/collapses to reveal content.
  expandable,

  /// Card that can be toggled into a selected state.
  selectable,
}

/// A flexible card component following the WidgetX design system.
///
/// Example:
/// ```dart
/// WidgetXCard(
///   title: Text('Order Summary'),
///   body: Text('3 items'),
/// )
/// ```
class WidgetXCard extends StatelessWidget {
  /// Creates a [WidgetXCard].
  const WidgetXCard({
    super.key,
    this.title,
    this.subtitle,
    this.body,
    this.header,
    this.footer,
    this.leading,
    this.trailing,
    this.padding,
    this.onTap,
    this.isSelected = false,
    this.isLoading = false,
    this.semanticDescription,
    this.variant = WidgetXCardVariant.basic,
  });

  final Widget? title;
  final Widget? subtitle;
  final Widget? body;
  final Widget? header;
  final Widget? footer;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isLoading;
  final String? semanticDescription;
  final WidgetXCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final effectivePadding = padding ?? const EdgeInsets.all(WidgetXSpacing.md);

    Widget content;
    if (isLoading) {
      content = Padding(
        padding: effectivePadding,
        child: _LoadingContent(),
      );
    } else {
      content = Padding(
        padding: effectivePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (header != null) ...[
              header!,
              const SizedBox(height: WidgetXSpacing.sm)
            ],
            if (title != null || leading != null || trailing != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (leading != null) ...[
                    leading!,
                    const SizedBox(width: WidgetXSpacing.sm),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null)
                          DefaultTextStyle(
                            style: Theme.of(context).textTheme.titleMedium!,
                            child: title!,
                          ),
                        if (subtitle != null)
                          DefaultTextStyle(
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: cs.onSurfaceVariant),
                            child: subtitle!,
                          ),
                      ],
                    ),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
            if (body != null) ...[
              const SizedBox(height: WidgetXSpacing.sm),
              body!,
            ],
            if (footer != null) ...[
              const SizedBox(height: WidgetXSpacing.sm),
              const Divider(),
              footer!,
            ],
          ],
        ),
      );
    }

    return Semantics(
      label: semanticDescription,
      selected: isSelected,
      child: AnimatedContainer(
        duration: WidgetXMotion.normal,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? cs.primary : cs.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected
              ? cs.primaryContainer.withValues(alpha: 0.3)
              : cs.surface,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: content,
          ),
        ),
      ),
    );
  }
}

/// A card that expands and collapses its body.
class WidgetXExpandableCard extends StatefulWidget {
  const WidgetXExpandableCard({
    super.key,
    required this.title,
    required this.expandedContent,
    this.subtitle,
    this.initiallyExpanded = false,
    this.padding,
    this.semanticDescription,
  });

  final Widget title;
  final Widget expandedContent;
  final Widget? subtitle;
  final bool initiallyExpanded;
  final EdgeInsetsGeometry? padding;
  final String? semanticDescription;

  @override
  State<WidgetXExpandableCard> createState() => _WidgetXExpandableCardState();
}

class _WidgetXExpandableCardState extends State<WidgetXExpandableCard>
    with SingleTickerProviderStateMixin {
  late bool _expanded;
  late AnimationController _ctrl;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    _ctrl = AnimationController(
      vsync: this,
      duration: WidgetXMotion.normal,
      value: _expanded ? 1.0 : 0.0,
    );
    _rotation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _ctrl, curve: WidgetXMotion.standard),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    _expanded ? _ctrl.forward() : _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final padding = widget.padding ?? const EdgeInsets.all(WidgetXSpacing.md);

    return Semantics(
      label: widget.semanticDescription,
      expanded: _expanded,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cs.outlineVariant),
          color: cs.surface,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: _toggle,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: padding,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultTextStyle(
                              style: Theme.of(context).textTheme.titleMedium!,
                              child: widget.title,
                            ),
                            if (widget.subtitle != null)
                              DefaultTextStyle(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: cs.onSurfaceVariant),
                                child: widget.subtitle!,
                              ),
                          ],
                        ),
                      ),
                      RotationTransition(
                        turns: _rotation,
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedSize(
                duration: WidgetXMotion.normal,
                curve: WidgetXMotion.standard,
                child: _expanded
                    ? Padding(padding: padding, child: widget.expandedContent)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _shimmerBox(context, width: 120, height: 16),
        const SizedBox(height: WidgetXSpacing.xs),
        _shimmerBox(context, width: double.infinity, height: 14),
        const SizedBox(height: WidgetXSpacing.xs),
        _shimmerBox(context, width: double.infinity, height: 14),
        const SizedBox(height: WidgetXSpacing.xs),
        _shimmerBox(context, width: 80, height: 14),
      ],
    );
  }

  Widget _shimmerBox(BuildContext context,
      {required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
