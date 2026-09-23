import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks the in-session navigation history for shell-level back navigation.
///
/// Because the sidebar uses [GoRouter.go] (which replaces rather than pushes
/// onto the Navigator stack), the system back button has no history to pop and
/// closes the app. This provider maintains a manual history so the shell can
/// navigate back through previously-visited routes.
final navHistoryProvider =
    NotifierProvider<NavHistoryNotifier, List<String>>(NavHistoryNotifier.new);

class NavHistoryNotifier extends Notifier<List<String>> {
  @override
  List<String> build() => [];

  /// Call this **before** navigating away from [path].
  void push(String path) {
    state = [...state, path];
  }

  /// Removes and returns the last path, or null if the stack is empty.
  String? pop() {
    if (state.isEmpty) return null;
    final last = state.last;
    state = state.sublist(0, state.length - 1);
    return last;
  }

  bool get canPop => state.isNotEmpty;
}
