import 'package:flutter/material.dart';
import '../foundations/motion/widgetx_motion.dart';
import '../foundations/spacing/widgetx_spacing.dart';

/// A single item in a [WidgetXToggleButtonGroup].
class WidgetXToggleItem {
  const WidgetXToggleItem({
    required this.label,
    this.icon,
    this.semanticLabel,
  });

  final String label;
  final IconData? icon;
  final String? semanticLabel;
}

/// A group of mutually-exclusive toggle buttons.
///
/// Unlike [WidgetXSegmentedControl], [WidgetXToggleButtonGroup] supports
/// multi-select mode and renders as a row of outlined icon-text buttons.
///
/// Example:
/// ```dart
/// WidgetXToggleButtonGroup(
///   items: const [
///     WidgetXToggleItem(label: 'Bold', icon: Icons.format_bold),
///     WidgetXToggleItem(label: 'Italic', icon: Icons.format_italic),
///   ],
///   selectedIndices: {0},
///   onChanged: (indices) => setState(() => _selected = indices),
///   allowMultiple: true,
/// )
/// ```
class WidgetXToggleButtonGroup extends StatelessWidget {
  const WidgetXToggleButtonGroup({
    super.key,
    required this.items,
    required this.selectedIndices,
    required this.onChanged,
    this.allowMultiple = false,
    this.isEnabled = true,
  });

  final List<WidgetXToggleItem> items;
  final Set<int> selectedIndices;
  final ValueChanged<Set<int>> onChanged;

  /// When true, multiple buttons can be active at the same time.
  final bool allowMultiple;
  final bool isEnabled;

  void _toggle(int index) {
    final next = Set<int>.from(selectedIndices);
    if (allowMultiple) {
      if (next.contains(index)) {
        next.remove(index);
      } else {
        next.add(index);
      }
    } else {
      next
        ..clear()
        ..add(index);
    }
    onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < items.length; i++) _ToggleButton(
          item: items[i],
          isSelected: selectedIndices.contains(i),
          isFirst: i == 0,
          isLast: i == items.length - 1,
          isEnabled: isEnabled,
          onTap: () => _toggle(i),
          cs: cs,
        ),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({
    required this.item,
    required this.isSelected,
    required this.isFirst,
    required this.isLast,
    required this.isEnabled,
    required this.onTap,
    required this.cs,
  });

  final WidgetXToggleItem item;
  final bool isSelected;
  final bool isFirst;
  final bool isLast;
  final bool isEnabled;
  final VoidCallback onTap;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.horizontal(
      left: isFirst ? const Radius.circular(8) : Radius.zero,
      right: isLast ? const Radius.circular(8) : Radius.zero,
    );

    return Semantics(
      label: item.semanticLabel ?? item.label,
      button: true,
      selected: isSelected,
      enabled: isEnabled,
      child: AnimatedContainer(
        duration: WidgetXMotion.fast,
        decoration: BoxDecoration(
          color: isSelected ? cs.primaryContainer : Colors.transparent,
          borderRadius: borderRadius,
          border: Border.all(
            color: isSelected ? cs.primary : cs.outline,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius,
          child: InkWell(
            onTap: isEnabled ? onTap : null,
            borderRadius: borderRadius,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: WidgetXSpacing.sm + 4,
                vertical: WidgetXSpacing.sm,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.icon != null) ...[
                    Icon(
                      item.icon,
                      size: 18,
                      color: isSelected
                          ? cs.onPrimaryContainer
                          : isEnabled
                              ? cs.onSurface
                              : cs.onSurface.withValues(alpha: 0.38),
                    ),
                    const SizedBox(width: WidgetXSpacing.xs),
                  ],
                  Text(
                    item.label,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: isSelected
                              ? cs.onPrimaryContainer
                              : isEnabled
                                  ? cs.onSurface
                                  : cs.onSurface.withValues(alpha: 0.38),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
