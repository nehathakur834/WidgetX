import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import 'favorite_button.dart';

/// A title + optional heart row that sits at the very top of a catalog screen's
/// ListView, replacing the inner Scaffold/AppBar pattern so the shell AppBar
/// stays as the single top bar on every screen size.
class ScreenTitleHeader extends StatelessWidget {
  const ScreenTitleHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.favoriteId,
  });

  final String title;
  final String? subtitle;

  /// When non-null a [FavoriteButton] is shown as a trailing icon.
  final String? favoriteId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: WidgetXSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ],
            ),
          ),
          if (favoriteId != null) FavoriteButton(id: favoriteId!),
        ],
      ),
    );
  }
}
