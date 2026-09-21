import 'package:flutter/material.dart';

/// A WidgetX-styled list tile.
///
/// Wraps Flutter's [ListTile] with WidgetX theming and semantics.
class WidgetXListTile extends StatelessWidget {
  const WidgetXListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.isSelected = false,
    this.isEnabled = true,
    this.semanticLabel,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isEnabled;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? title,
      selected: isSelected,
      enabled: isEnabled,
      child: ListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        leading: leading,
        trailing: trailing,
        onTap: isEnabled ? onTap : null,
        selected: isSelected,
        enabled: isEnabled,
      ),
    );
  }
}

/// A key–value display row.
class WidgetXKeyValueRow extends StatelessWidget {
  const WidgetXKeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.semanticLabel,
  });

  final String label;
  final String value;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Semantics(
      label: semanticLabel ?? '$label: $value',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
