import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/theme_provider.dart';
import '../providers/search_provider.dart';
import '../providers/recent_items_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/nav_history_provider.dart';
import '../catalog/device_preview_widgets.dart';
import '../catalog/favorite_button.dart';

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();
  final _layerLink = LayerLink();
  OverlayEntry? _overlay;

  @override
  void initState() {
    super.initState();
    _searchFocus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_searchFocus.hasFocus) {
      _showOverlay();
    } else {
      _hideOverlay();
    }
  }

  void _showOverlay() {
    _overlay?.remove();
    _overlay = OverlayEntry(
      builder: (_) => _SearchOverlay(
        link: _layerLink,
        onClose: () {
          _searchFocus.unfocus();
          _hideOverlay();
        },
      ),
    );
    Overlay.of(context).insert(_overlay!);
  }

  void _hideOverlay() {
    _overlay?.remove();
    _overlay = null;
  }

  @override
  void dispose() {
    _overlay?.remove();
    _searchController.dispose();
    _searchFocus.removeListener(_onFocusChange);
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 1024;
    final isTablet = width >= 600 && width < 1024;

    if (isDesktop) {
      return _DesktopShell(
        searchController: _searchController,
        searchFocus: _searchFocus,
        layerLink: _layerLink,
        child: widget.child,
      );
    } else if (isTablet) {
      return _TabletShell(
        searchController: _searchController,
        searchFocus: _searchFocus,
        layerLink: _layerLink,
        child: widget.child,
      );
    } else {
      return _MobileShell(
        searchController: _searchController,
        searchFocus: _searchFocus,
        layerLink: _layerLink,
        child: widget.child,
      );
    }
  }
}

// ── Nav items ─────────────────────────────────────────────────────────────────

class _NavSection {
  const _NavSection(this.label, this.items);
  final String label;
  final List<_NavItem> items;
}

class _NavItem {
  const _NavItem(this.label, this.icon, this.route);
  final String label;
  final IconData icon;
  final String route;
}

/// Maps route path → (display title, favoriteId).
/// A null title means the route is a full-screen template that owns its own
/// AppBar — the shell must render appBar: null for those routes.
const _routeMeta = <String, (String?, String?)>{
  // ── Component screens ────────────────────────────────────────────────────
  '/': ('Overview', null),
  '/foundations': ('Foundations', 'foundations'),
  '/buttons': ('Buttons', 'buttons'),
  '/inputs': ('Inputs', 'inputs'),
  '/cards': ('Cards', 'cards'),
  '/navigation': ('Navigation', 'navigation'),
  '/dialogs': ('Dialogs & Sheets', 'dialogs'),
  '/feedback': ('Feedback', 'feedback'),
  '/data-display': ('Data Display', 'data-display'),
  '/charts': ('Charts', 'charts'),
  '/layout': ('Responsive Layout', 'layout'),
  '/accessibility': ('Accessibility', 'accessibility'),
  '/templates': ('Templates', null),
  // ── Template screens — own their own AppBar ──────────────────────────────
  '/templates/auth/login': (null, null),
  '/templates/auth/register': (null, null),
  '/templates/auth/welcome': (null, null),
  '/templates/auth/onboarding': (null, null),
  '/templates/auth/forgot-password': (null, null),
  '/templates/auth/otp': (null, null),
  '/templates/dashboard': (null, null),
  '/templates/ecommerce': (null, null),
  '/templates/ecommerce/product': (null, null),
  '/templates/ecommerce/cart': (null, null),
  '/templates/finance': (null, null),
  '/templates/realestate': (null, null),
  '/templates/realestate/details': (null, null),
  '/templates/social': (null, null),
  '/templates/food': (null, null),
  '/templates/productivity': (null, null),
  '/templates/portfolio': (null, null),
  '/templates/settings': (null, null),
  '/templates/booking': (null, null),
};

const _navSections = [
  _NavSection('', [
    _NavItem('Overview', Icons.home_outlined, '/'),
  ]),
  _NavSection('Components', [
    _NavItem('Foundations', Icons.palette_outlined, '/foundations'),
    _NavItem('Buttons', Icons.smart_button_outlined, '/buttons'),
    _NavItem('Inputs', Icons.input_outlined, '/inputs'),
    _NavItem('Cards', Icons.credit_card_outlined, '/cards'),
    _NavItem('Navigation', Icons.compass_calibration_outlined, '/navigation'),
    _NavItem('Dialogs', Icons.layers_outlined, '/dialogs'),
    _NavItem('Feedback', Icons.notifications_outlined, '/feedback'),
    _NavItem('Data Display', Icons.table_chart_outlined, '/data-display'),
    _NavItem('Charts', Icons.bar_chart_outlined, '/charts'),
    _NavItem('Layout', Icons.view_quilt_outlined, '/layout'),
    _NavItem('Accessibility', Icons.accessibility_new_outlined, '/accessibility'),
  ]),
  _NavSection('Templates', [
    _NavItem('All Templates', Icons.grid_view_outlined, '/templates'),
    _NavItem('Auth', Icons.lock_outline, '/templates/auth/login'),
    _NavItem('Dashboard', Icons.dashboard_outlined, '/templates/dashboard'),
    _NavItem('E-Commerce', Icons.storefront_outlined, '/templates/ecommerce'),
    _NavItem('Finance', Icons.account_balance_outlined, '/templates/finance'),
    _NavItem('Real Estate', Icons.home_work_outlined, '/templates/realestate'),
    _NavItem('Social', Icons.people_outline, '/templates/social'),
    _NavItem('Food', Icons.restaurant_outlined, '/templates/food'),
    _NavItem('Booking', Icons.hotel_outlined, '/templates/booking'),
    _NavItem('Productivity', Icons.check_circle_outline, '/templates/productivity'),
    _NavItem('Portfolio', Icons.person_outline, '/templates/portfolio'),
    _NavItem('Settings', Icons.settings_outlined, '/templates/settings'),
  ]),
];

// ── Desktop shell ─────────────────────────────────────────────────────────────

class _DesktopShell extends ConsumerWidget {
  const _DesktopShell({
    required this.child,
    required this.searchController,
    required this.searchFocus,
    required this.layerLink,
  });
  final Widget child;
  final TextEditingController searchController;
  final FocusNode searchFocus;
  final LayerLink layerLink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: Row(
        children: [
          const _Sidebar(width: 240),
          VerticalDivider(width: 1, color: cs.outlineVariant),
          Expanded(
            child: Column(
              children: [
                _TopBar(
                  searchController: searchController,
                  searchFocus: searchFocus,
                  layerLink: layerLink,
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tablet shell ──────────────────────────────────────────────────────────────

class _TabletShell extends ConsumerWidget {
  const _TabletShell({
    required this.child,
    required this.searchController,
    required this.searchFocus,
    required this.layerLink,
  });
  final Widget child;
  final TextEditingController searchController;
  final FocusNode searchFocus;
  final LayerLink layerLink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = GoRouterState.of(context).uri.path;
    final meta = _routeMeta[path];
    final title = meta?.$1;           // null → template owns its own AppBar
    final favId = meta?.$2;
    final canPop = ref.watch(navHistoryProvider.select((h) => h.isNotEmpty));
    return PopScope(
      canPop: !canPop && path == '/',
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        final prev = ref.read(navHistoryProvider.notifier).pop();
        if (prev != null) {
          context.go(prev);
        } else if (path != '/') {
          context.go('/');
        }
      },
      child: Scaffold(
        drawer: const Drawer(child: _Sidebar(width: 280)),
        appBar: title == null
            ? null
            : AppBar(
                title: Text(title),
                centerTitle: false,
                actions: [
                  if (favId != null) FavoriteButton(id: favId),
                  _FavoritesButton(),
                  _ThemeToggle(),
                  const SizedBox(width: 8),
                ],
              ),
        body: child,
      ),
    );
  }
}

// ── Mobile shell ──────────────────────────────────────────────────────────────

class _MobileShell extends ConsumerWidget {
  const _MobileShell({
    required this.child,
    required this.searchController,
    required this.searchFocus,
    required this.layerLink,
  });
  final Widget child;
  final TextEditingController searchController;
  final FocusNode searchFocus;
  final LayerLink layerLink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = GoRouterState.of(context).uri.path;
    final meta = _routeMeta[path];
    final title = meta?.$1;           // null → template owns its own AppBar
    final favId = meta?.$2;
    final canPop = ref.watch(navHistoryProvider.select((h) => h.isNotEmpty));
    return PopScope(
      canPop: !canPop && path == '/',
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        final prev = ref.read(navHistoryProvider.notifier).pop();
        if (prev != null) {
          context.go(prev);
        } else if (path != '/') {
          context.go('/');
        }
      },
      child: Scaffold(
        drawer: const Drawer(child: _Sidebar(width: 280)),
        appBar: title == null
            ? null
            : AppBar(
                title: Text(title),
                centerTitle: false,
                actions: [
                  if (favId != null) FavoriteButton(id: favId),
                  _FavoritesButton(),
                  _ThemeToggle(),
                  const SizedBox(width: 8),
                ],
              ),
        body: child,
      ),
    );
  }
}

// ── Sidebar ───────────────────────────────────────────────────────────────────

class _Sidebar extends ConsumerWidget {
  const _Sidebar({required this.width});
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final currentLocation = GoRouterState.of(context).uri.path;
    final recents = ref.watch(recentItemsProvider);

    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Padding(
            padding: EdgeInsets.fromLTRB(16, 20 + topPadding, 16, 16),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: cs.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.widgets_outlined,
                      color: cs.onPrimary, size: 18),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WidgetX UI',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Flutter Design System',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Nav items
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8 + bottomPadding),
              children: [
                // Recent items section (shown only when populated)
                if (recents.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                    child: Text(
                      'RECENT',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: cs.onSurfaceVariant,
                            letterSpacing: 0.8,
                          ),
                    ),
                  ),
                  for (final item in recents.take(5))
                    _SidebarItem(
                      item: _NavItem(item.label, Icons.history, item.route),
                      isActive: currentLocation == item.route,
                    ),
                  const Divider(height: 1),
                  const SizedBox(height: 4),
                ],
                // Main nav
                for (final section in _navSections) ...[
                  if (section.label.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 12, 8, 4),
                      child: Text(
                        section.label.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(
                              color: cs.onSurfaceVariant,
                              letterSpacing: 0.8,
                            ),
                      ),
                    ),
                  for (final item in section.items)
                    _SidebarItem(
                      item: item,
                      isActive: currentLocation == item.route ||
                          (item.route != '/' &&
                              currentLocation.startsWith(item.route)),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends ConsumerWidget {
  const _SidebarItem({required this.item, required this.isActive});
  final _NavItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    return Semantics(
      selected: isActive,
      child: InkWell(
        onTap: () {
          if (Scaffold.of(context).isDrawerOpen) {
            Navigator.of(context).pop();
          }
          // Push current path onto history before navigating away
          final currentPath = GoRouterState.of(context).uri.path;
          if (currentPath != item.route) {
            ref.read(navHistoryProvider.notifier).push(currentPath);
          }
          // Record in recents
          ref.read(recentItemsProvider.notifier).record(
                RecentItem(
                  id: item.route,
                  label: item.label,
                  route: item.route,
                ),
              );
          context.go(item.route);
        },
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isActive ? cs.primaryContainer : Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(
                item.icon,
                size: 17,
                color: isActive ? cs.onPrimaryContainer : cs.onSurfaceVariant,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            isActive ? cs.onPrimaryContainer : cs.onSurface,
                        fontWeight:
                            isActive ? FontWeight.w600 : FontWeight.normal,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Top bar ───────────────────────────────────────────────────────────────────

class _TopBar extends ConsumerWidget {
  const _TopBar({
    required this.searchController,
    required this.searchFocus,
    required this.layerLink,
  });
  final TextEditingController searchController;
  final FocusNode searchFocus;
  final LayerLink layerLink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(bottom: BorderSide(color: cs.outlineVariant)),
      ),
      child: Row(
        children: [
          Expanded(
            child: CompositedTransformTarget(
              link: layerLink,
              child: TextField(
                controller: searchController,
                focusNode: searchFocus,
                onChanged: (v) =>
                    ref.read(searchQueryProvider.notifier).state = v,
                decoration: InputDecoration(
                  hintText: 'Search components, templates…',
                  prefixIcon: const Icon(Icons.search, size: 18),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 16),
                          onPressed: () {
                            searchController.clear();
                            ref.read(searchQueryProvider.notifier).state = '';
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: cs.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: cs.outlineVariant),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  isDense: true,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const DevicePreviewToggle(),
          const SizedBox(width: 8),
          _ThemeToggle(),
          const SizedBox(width: 8),
          _AccentButton(),
          const SizedBox(width: 8),
          _FavoritesButton(),
          const SizedBox(width: 4),
          IconButton(
            icon: const Icon(Icons.open_in_new, size: 18),
            tooltip: 'GitHub — github.com/widgetx-ui/widgetx_ui',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('github.com/widgetx-ui/widgetx_ui'),
                  duration: Duration(seconds: 3),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ── Search overlay ────────────────────────────────────────────────────────────

class _SearchOverlay extends ConsumerWidget {
  const _SearchOverlay({required this.link, required this.onClose});
  final LayerLink link;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(searchResultsProvider);
    final query = ref.watch(searchQueryProvider);

    // Dismiss on tap outside
    return GestureDetector(
      onTap: onClose,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            offset: const Offset(0, 44),
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 520,
                  maxHeight: 400,
                ),
                child: GestureDetector(
                  onTap: () {}, // prevent dismiss when tapping inside
                  child: _SearchResults(
                    results: results,
                    query: query,
                    onSelect: (entry) {
                      onClose();
                      final currentPath =
                          GoRouterState.of(context).uri.path;
                      if (currentPath != entry.route) {
                        ref
                            .read(navHistoryProvider.notifier)
                            .push(currentPath);
                      }
                      ref
                          .read(recentItemsProvider.notifier)
                          .record(RecentItem(
                            id: entry.id,
                            label: entry.label,
                            route: entry.route,
                          ));
                      context.go(entry.route);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({
    required this.results,
    required this.query,
    required this.onSelect,
  });
  final List<SearchEntry> results;
  final String query;
  final ValueChanged<SearchEntry> onSelect;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    if (query.isEmpty) {
      return const SizedBox.shrink();
    }

    if (results.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 32, color: cs.onSurfaceVariant),
            const SizedBox(height: 8),
            Text('No results for "$query"',
                style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
          ],
        ),
      );
    }

    // Group by category
    final grouped = <String, List<SearchEntry>>{};
    for (final e in results) {
      grouped.putIfAbsent(e.category, () => []).add(e);
    }

    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: [
        for (final entry in grouped.entries) ...[
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
            color: cs.surfaceContainerHighest,
            child: Text(
              entry.key.toUpperCase(),
              style: tt.labelSmall?.copyWith(
                color: cs.onSurfaceVariant,
                letterSpacing: 0.8,
              ),
            ),
          ),
          for (final item in entry.value)
            InkWell(
              onTap: () => onSelect(item),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    Icon(
                      item.category == 'Templates'
                          ? Icons.dashboard_outlined
                          : Icons.widgets_outlined,
                      size: 16,
                      color: cs.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(item.label,
                          style: tt.bodyMedium),
                    ),
                    Text(
                      item.category,
                      style: tt.labelSmall
                          ?.copyWith(color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ],
    );
  }
}

// ── Favorites button ──────────────────────────────────────────────────────────

class _FavoritesButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    return IconButton(
      icon: Badge(
        isLabelVisible: favorites.isNotEmpty,
        label: Text('${favorites.length}'),
        child: const Icon(Icons.favorite_border, size: 18),
      ),
      tooltip: 'Favorites',
      onPressed: () => _showFavoritesSheet(context, ref),
    );
  }

  void _showFavoritesSheet(BuildContext context, WidgetRef ref) {
    final favorites = ref.read(favoritesProvider);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => UncontrolledProviderScope(
        container: ProviderScope.containerOf(context),
        child: _FavoritesSheet(favoriteIds: favorites),
      ),
    );
  }
}

class _FavoritesSheet extends ConsumerWidget {
  const _FavoritesSheet({required this.favoriteIds});
  final Set<String> favoriteIds;

  /// Map from route-id to route path (same ids used in search index)
  static const _routeMap = {
    'foundations': '/foundations',
    'buttons': '/buttons',
    'inputs': '/inputs',
    'cards': '/cards',
    'navigation': '/navigation',
    'dialogs': '/dialogs',
    'feedback': '/feedback',
    'data-display': '/data-display',
    'charts': '/charts',
    'layout': '/layout',
    'accessibility': '/accessibility',
    'tpl-welcome': '/templates/auth/welcome',
    'tpl-login': '/templates/auth/login',
    'tpl-register': '/templates/auth/register',
    'tpl-forgot-password': '/templates/auth/forgot-password',
    'tpl-otp': '/templates/auth/otp',
    'tpl-onboarding': '/templates/auth/onboarding',
    'tpl-dashboard': '/templates/dashboard',
    'tpl-ecommerce': '/templates/ecommerce',
    'tpl-product': '/templates/ecommerce/product',
    'tpl-cart': '/templates/ecommerce/cart',
    'tpl-finance': '/templates/finance',
    'tpl-realestate': '/templates/realestate',
    'tpl-property-details': '/templates/realestate/details',
    'tpl-social': '/templates/social',
    'tpl-food': '/templates/food',
    'tpl-productivity': '/templates/productivity',
    'tpl-portfolio': '/templates/portfolio',
    'tpl-booking': '/templates/booking',
    'tpl-settings': '/templates/settings',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final currentFaves = ref.watch(favoritesProvider);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      builder: (context, scrollController) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
            child: Text('Favorites',
                style: tt.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          ),
          if (currentFaves.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite_border,
                        size: 40, color: cs.onSurfaceVariant),
                    const SizedBox(height: 8),
                    Text('No favorites yet',
                        style: tt.bodyMedium
                            ?.copyWith(color: cs.onSurfaceVariant)),
                    const SizedBox(height: 4),
                    Text('Tap ♥ on any template or component screen.',
                        style: tt.bodySmall
                            ?.copyWith(color: cs.onSurfaceVariant)),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: currentFaves.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (_, i) {
                  final id = currentFaves.elementAt(i);
                  final route = _routeMap[id];
                  return ListTile(
                    leading: Icon(Icons.favorite,
                        color: cs.primary, size: 20),
                    title: Text(id.replaceAll('-', ' ')),
                    trailing: IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () =>
                          ref.read(favoritesProvider.notifier).toggle(id),
                    ),
                    onTap: route != null
                        ? () {
                            final current =
                                GoRouterState.of(context).uri.path;
                            Navigator.of(context).pop();
                            if (current != route) {
                              ref
                                  .read(navHistoryProvider.notifier)
                                  .push(current);
                            }
                            context.go(route);
                          }
                        : null,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

// ── Theme toggle ──────────────────────────────────────────────────────────────

class _ThemeToggle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    return PopupMenuButton<ThemeMode>(
      icon: Icon(_icon(mode), size: 20),
      tooltip: 'Switch theme',
      onSelected: (m) => ref.read(themeModeProvider.notifier).setMode(m),
      itemBuilder: (_) => const [
        PopupMenuItem(value: ThemeMode.light, child: Text('Light')),
        PopupMenuItem(value: ThemeMode.dark, child: Text('Dark')),
        PopupMenuItem(value: ThemeMode.system, child: Text('System')),
      ],
    );
  }

  IconData _icon(ThemeMode m) => switch (m) {
        ThemeMode.light => Icons.light_mode,
        ThemeMode.dark => Icons.dark_mode,
        ThemeMode.system => Icons.brightness_auto,
      };
}

// ── Accent button ─────────────────────────────────────────────────────────────

class _AccentButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(accentIndexProvider);
    final color = AccentIndexNotifier.accentColors[index];
    return PopupMenuButton<int>(
      tooltip: 'Accent color',
      icon: CircleAvatar(backgroundColor: color, radius: 10),
      onSelected: (i) =>
          ref.read(accentIndexProvider.notifier).setIndex(i),
      itemBuilder: (_) => [
        for (var i = 0; i < AccentIndexNotifier.accentColors.length; i++)
          PopupMenuItem(
            value: i,
            child: Row(
              children: [
                CircleAvatar(
                    backgroundColor: AccentIndexNotifier.accentColors[i],
                    radius: 8),
                const SizedBox(width: 8),
                Text(AccentIndexNotifier.accentNames[i]),
              ],
            ),
          ),
      ],
    );
  }
}
