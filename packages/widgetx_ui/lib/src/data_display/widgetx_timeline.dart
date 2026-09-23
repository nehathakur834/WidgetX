import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';
import '../foundations/motion/widgetx_motion.dart';

/// A single item in a [WidgetXTimeline].
class WidgetXTimelineItem {
  const WidgetXTimelineItem({
    required this.title,
    this.subtitle,
    this.time,
    this.icon,
    this.isCompleted = false,
    this.isActive = false,
  });

  final String title;
  final String? subtitle;
  final String? time;
  final IconData? icon;
  final bool isCompleted;
  final bool isActive;
}

/// A vertical timeline of events following the WidgetX design system.
///
/// Example:
/// ```dart
/// WidgetXTimeline(
///   items: [
///     WidgetXTimelineItem(title: 'Order placed', time: '09:00', isCompleted: true),
///     WidgetXTimelineItem(title: 'In transit', isActive: true),
///   ],
/// )
/// ```
class WidgetXTimeline extends StatelessWidget {
  /// Creates a [WidgetXTimeline].
  const WidgetXTimeline({super.key, required this.items});

  final List<WidgetXTimelineItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < items.length; i++)
          _TimelineRow(
            item: items[i],
            isLast: i == items.length - 1,
          ),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.item, required this.isLast});

  final WidgetXTimelineItem item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dotColor = item.isCompleted
        ? cs.primary
        : item.isActive
            ? cs.primary.withValues(alpha: 0.7)
            : cs.outlineVariant;
    final lineColor = item.isCompleted ? cs.primary : cs.outlineVariant;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column (dot + line)
          SizedBox(
            width: 32,
            child: Column(
              children: [
                // Dot
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item.isCompleted || item.isActive
                        ? dotColor
                        : cs.surface,
                    border: Border.all(color: dotColor, width: 2),
                  ),
                  child: item.isCompleted
                      ? Icon(
                          item.icon ?? Icons.check,
                          size: 12,
                          color: cs.onPrimary,
                        )
                      : item.icon != null
                          ? Icon(item.icon, size: 12, color: cs.primary)
                          : null,
                ),
                // Connector line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: lineColor,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: WidgetXSpacing.sm),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: isLast ? 0 : WidgetXSpacing.lg,
                top: 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      if (item.time != null)
                        Text(
                          item.time!,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: cs.onSurfaceVariant,
                                  ),
                        ),
                    ],
                  ),
                  if (item.subtitle != null) ...[
                    const SizedBox(height: WidgetXSpacing.xxs),
                    Text(
                      item.subtitle!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A single accordion item for [WidgetXAccordion].
class WidgetXAccordionItem {
  const WidgetXAccordionItem({
    required this.title,
    required this.content,
    this.subtitle,
    this.icon,
    this.initiallyExpanded = false,
  });

  final String title;
  final Widget content;
  final String? subtitle;
  final IconData? icon;
  final bool initiallyExpanded;
}

/// An accordion list — multiple expand/collapse panels.
///
/// Example:
/// ```dart
/// WidgetXAccordion(
///   items: [
///     WidgetXAccordionItem(title: 'FAQ 1', content: Text('Answer 1')),
///   ],
///   allowMultiple: false,
/// )
/// ```
class WidgetXAccordion extends StatefulWidget {
  /// Creates a [WidgetXAccordion].
  const WidgetXAccordion({
    super.key,
    required this.items,
    this.allowMultiple = true,
  });

  final List<WidgetXAccordionItem> items;

  /// If false, expanding one item collapses all others.
  final bool allowMultiple;

  @override
  State<WidgetXAccordion> createState() => _WidgetXAccordionState();
}

class _WidgetXAccordionState extends State<WidgetXAccordion> {
  late List<bool> _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.items.map((item) => item.initiallyExpanded).toList();
  }

  void _toggle(int index) {
    setState(() {
      if (!widget.allowMultiple) {
        _expanded = List.filled(widget.items.length, false);
      }
      _expanded[index] = !_expanded[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < widget.items.length; i++)
          _AccordionPanel(
            item: widget.items[i],
            isExpanded: _expanded[i],
            onToggle: () => _toggle(i),
          ),
      ],
    );
  }
}

class _AccordionPanel extends StatelessWidget {
  const _AccordionPanel({
    required this.item,
    required this.isExpanded,
    required this.onToggle,
  });

  final WidgetXAccordionItem item;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Semantics(
      expanded: isExpanded,
      child: Container(
        margin: const EdgeInsets.only(bottom: WidgetXSpacing.xs),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cs.outlineVariant),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: onToggle,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(WidgetXSpacing.md),
                  child: Row(
                    children: [
                      if (item.icon != null) ...[
                        Icon(item.icon, size: 20, color: cs.primary),
                        const SizedBox(width: WidgetXSpacing.sm),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            if (item.subtitle != null)
                              Text(
                                item.subtitle!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: cs.onSurfaceVariant),
                              ),
                          ],
                        ),
                      ),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration: WidgetXMotion.normal,
                        curve: WidgetXMotion.standard,
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedSize(
                duration: WidgetXMotion.normal,
                curve: WidgetXMotion.standard,
                child: isExpanded
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: WidgetXSpacing.md,
                          right: WidgetXSpacing.md,
                          bottom: WidgetXSpacing.md,
                        ),
                        child: item.content,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
