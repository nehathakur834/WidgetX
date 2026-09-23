import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/favorites_provider.dart';

/// A lightweight top-bar used inside template screens that don't have a
/// full sidebar shell AppBar. Shows a back button, title, and a favorite
/// toggle.
class TemplateAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const TemplateAppBar({
    super.key,
    required this.title,
    required this.favoriteId,
    this.subtitle,
    this.actions = const [],
  });

  final String title;
  final String favoriteId;
  final String? subtitle;
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFav = ref.watch(
      favoritesProvider.select((s) => s.contains(favoriteId)),
    );
    return AppBar(
      title: subtitle != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(subtitle!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant)),
              ],
            )
          : Text(title),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/');
          }
        },
      ),
      actions: [
        ...actions,
        Semantics(
          label: isFav ? 'Remove from favorites' : 'Add to favorites',
          button: true,
          child: IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(isFav),
                color: isFav ? Colors.red : null,
                size: 20,
              ),
            ),
            tooltip: isFav ? 'Remove from favorites' : 'Add to favorites',
            onPressed: () =>
                ref.read(favoritesProvider.notifier).toggle(favoriteId),
          ),
        ),
      ],
    );
  }
}
