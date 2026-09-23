import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';

/// A multi-select dropdown that allows selecting multiple items from a list.
///
/// Example:
/// ```dart
/// WidgetXMultiSelectDropdown<String>(
///   label: 'Technologies',
///   items: const ['Flutter', 'Dart', 'Firebase', 'Riverpod'],
///   itemLabel: (v) => v,
///   selectedValues: _selected,
///   onChanged: (v) => setState(() => _selected = v),
/// )
/// ```
class WidgetXMultiSelectDropdown<T> extends StatefulWidget {
  const WidgetXMultiSelectDropdown({
    super.key,
    required this.items,
    required this.itemLabel,
    required this.selectedValues,
    required this.onChanged,
    this.label,
    this.hint = 'Select options',
    this.isEnabled = true,
    this.semanticLabel,
  });

  final List<T> items;
  final String Function(T) itemLabel;
  final List<T> selectedValues;
  final ValueChanged<List<T>> onChanged;
  final String? label;
  final String hint;
  final bool isEnabled;
  final String? semanticLabel;

  @override
  State<WidgetXMultiSelectDropdown<T>> createState() =>
      _WidgetXMultiSelectDropdownState<T>();
}

class _WidgetXMultiSelectDropdownState<T>
    extends State<WidgetXMultiSelectDropdown<T>> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggle() {
    if (_isOpen) {
      _close();
    } else {
      _open();
    }
  }

  void _open() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (_) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _close,
        child: Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 4,
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height + 4),
                child: _DropdownPanel<T>(
                  items: widget.items,
                  itemLabel: widget.itemLabel,
                  selectedValues: widget.selectedValues,
                  onChanged: (updated) {
                    widget.onChanged(updated);
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
    overlay.insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() => _isOpen = false);
  }

  @override
  void dispose() {
    // Remove entry directly without setState — widget is already unmounting
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Semantics(
      label: widget.semanticLabel ?? widget.label,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.label != null)
              Padding(
                padding: const EdgeInsets.only(bottom: WidgetXSpacing.xs),
                child: Text(
                  widget.label!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                ),
              ),
            GestureDetector(
              onTap: widget.isEnabled ? _toggle : null,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: WidgetXSpacing.md,
                  vertical: WidgetXSpacing.sm + 2,
                ),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _isOpen ? cs.primary : cs.outline,
                    width: _isOpen ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: widget.selectedValues.isEmpty
                          ? Text(
                              widget.hint,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: cs.onSurfaceVariant),
                            )
                          : Wrap(
                              spacing: WidgetXSpacing.xs,
                              runSpacing: WidgetXSpacing.xs,
                              children: widget.selectedValues.map((v) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: WidgetXSpacing.sm,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: cs.primaryContainer,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        widget.itemLabel(v),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                              color: cs.onPrimaryContainer,
                                            ),
                                      ),
                                      const SizedBox(width: 2),
                                      GestureDetector(
                                        onTap: () {
                                          final updated =
                                              List<T>.from(widget.selectedValues)
                                                ..remove(v);
                                          widget.onChanged(updated);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          size: 12,
                                          color: cs.onPrimaryContainer,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                    ),
                    Icon(
                      _isOpen
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 20,
                      color: cs.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DropdownPanel<T> extends StatefulWidget {
  const _DropdownPanel({
    required this.items,
    required this.itemLabel,
    required this.selectedValues,
    required this.onChanged,
  });

  final List<T> items;
  final String Function(T) itemLabel;
  final List<T> selectedValues;
  final ValueChanged<List<T>> onChanged;

  @override
  State<_DropdownPanel<T>> createState() => _DropdownPanelState<T>();
}

class _DropdownPanelState<T> extends State<_DropdownPanel<T>> {
  late List<T> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      color: cs.surface,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 240),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cs.outlineVariant),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.items.length,
          padding: const EdgeInsets.symmetric(vertical: 4),
          itemBuilder: (_, i) {
            final item = widget.items[i];
            final isSelected = _selected.contains(item);
            return InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selected.remove(item);
                  } else {
                    _selected.add(item);
                  }
                });
                widget.onChanged(List.from(_selected));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: WidgetXSpacing.md,
                  vertical: WidgetXSpacing.sm,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.itemLabel(item),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    if (isSelected)
                      Icon(Icons.check, size: 18, color: cs.primary),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
