import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favorites_provider.dart';

/// A heart icon button that toggles a favorites entry.
///
/// Drop it into any screen's AppBar actions:
/// ```dart
/// actions: [FavoriteButton(id: 'buttons')]
/// ```
class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({super.key, required this.id});

  /// Unique identifier used to store this item in favorites.
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFav = ref.watch(
      favoritesProvider.select((s) => s.contains(id)),
    );
    return Semantics(
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
        onPressed: () => ref.read(favoritesProvider.notifier).toggle(id),
      ),
    );
  }
}
