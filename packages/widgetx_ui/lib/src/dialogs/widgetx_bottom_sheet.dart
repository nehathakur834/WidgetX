import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';

/// Shows a WidgetX-styled modal bottom sheet.
///
/// Example:
/// ```dart
/// showWidgetXBottomSheet(
///   context: context,
///   title: 'Select option',
///   body: MyOptionsWidget(),
/// );
/// ```
Future<T?> showWidgetXBottomSheet<T>({
  required BuildContext context,
  required Widget body,
  String? title,
  bool isDismissible = true,
  bool isScrollControlled = true,
  bool showDragHandle = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    isScrollControlled: isScrollControlled,
    showDragHandle: showDragHandle,
    builder: (ctx) => _WidgetXBottomSheetContent(
      title: title,
      body: body,
    ),
  );
}

class _WidgetXBottomSheetContent extends StatelessWidget {
  const _WidgetXBottomSheetContent({
    this.title,
    required this.body,
  });

  final String? title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: WidgetXSpacing.md,
          right: WidgetXSpacing.md,
          bottom: WidgetXSpacing.md + mediaQuery.viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: WidgetXSpacing.sm),
              const Divider(),
              const SizedBox(height: WidgetXSpacing.sm),
            ],
            body,
          ],
        ),
      ),
    );
  }
}

/// Shows a WidgetX-styled action sheet (list of labeled actions).
Future<int?> showWidgetXActionSheet({
  required BuildContext context,
  required List<WidgetXActionItem> actions,
  String? title,
}) {
  return showWidgetXBottomSheet<int>(
    context: context,
    title: title,
    body: _WidgetXActionList(actions: actions),
  );
}

class _WidgetXActionList extends StatelessWidget {
  const _WidgetXActionList({required this.actions});

  final List<WidgetXActionItem> actions;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < actions.length; i++)
          ListTile(
            leading: actions[i].icon != null
                ? Icon(
                    actions[i].icon,
                    color: actions[i].isDestructive ? cs.error : null,
                  )
                : null,
            title: Text(
              actions[i].label,
              style: actions[i].isDestructive
                  ? TextStyle(color: cs.error)
                  : null,
            ),
            onTap: () => Navigator.of(context).pop(i),
          ),
      ],
    );
  }
}

/// An item in a [showWidgetXActionSheet].
class WidgetXActionItem {
  const WidgetXActionItem({
    required this.label,
    this.icon,
    this.isDestructive = false,
  });

  final String label;
  final IconData? icon;
  final bool isDestructive;
}
