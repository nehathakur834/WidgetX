import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks which post IDs the current user has liked.
final socialLikesProvider =
    StateNotifierProvider<SocialLikesNotifier, Set<String>>(
  (ref) => SocialLikesNotifier(),
);

class SocialLikesNotifier extends StateNotifier<Set<String>> {
  SocialLikesNotifier() : super({});

  void toggle(String postId) {
    final next = Set<String>.from(state);
    if (next.contains(postId)) {
      next.remove(postId);
    } else {
      next.add(postId);
    }
    state = next;
  }

  bool isLiked(String postId) => state.contains(postId);
}
