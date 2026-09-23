import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A recently-visited item in the WidgetX app.
class RecentItem {
  const RecentItem({required this.id, required this.label, required this.route});
  final String id;
  final String label;
  final String route;

  String toStorageString() => '$id|$label|$route';

  static RecentItem? fromStorageString(String s) {
    final parts = s.split('|');
    if (parts.length < 3) return null;
    return RecentItem(id: parts[0], label: parts[1], route: parts[2]);
  }
}

final recentItemsProvider =
    StateNotifierProvider<RecentItemsNotifier, List<RecentItem>>(
  (ref) => RecentItemsNotifier(),
);

class RecentItemsNotifier extends StateNotifier<List<RecentItem>> {
  RecentItemsNotifier() : super([]) {
    _load();
  }

  static const _key = 'recent_items';
  static const _maxItems = 8;

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    state = raw.map(RecentItem.fromStorageString).whereType<RecentItem>().toList();
  }

  Future<void> record(RecentItem item) async {
    final updated = [
      item,
      ...state.where((r) => r.id != item.id),
    ].take(_maxItems).toList();
    state = updated;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, updated.map((r) => r.toStorageString()).toList());
  }

  Future<void> clear() async {
    state = [];
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
