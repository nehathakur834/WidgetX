import 'package:flutter/material.dart';
import '../foundations/spacing/widgetx_spacing.dart';
import '../foundations/motion/widgetx_motion.dart';

/// A pagination control component.
///
/// Example:
/// ```dart
/// WidgetXPagination(
///   currentPage: _page,
///   totalPages: 10,
///   onPageChanged: (page) => setState(() => _page = page),
/// )
/// ```
class WidgetXPagination extends StatelessWidget {
  const WidgetXPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.maxPagesVisible = 5,
    this.showFirstLast = true,
    this.semanticLabel,
  });

  /// Current active page (1-based).
  final int currentPage;

  /// Total number of pages.
  final int totalPages;

  /// Called when user taps a page button.
  final ValueChanged<int> onPageChanged;

  /// How many page number buttons to show at most (excluding prev/next/first/last).
  final int maxPagesVisible;

  /// Show first and last page jump buttons.
  final bool showFirstLast;

  final String? semanticLabel;

  List<int?> get _pages {
    // null = ellipsis
    if (totalPages <= maxPagesVisible) {
      return List.generate(totalPages, (i) => i + 1);
    }
    final half = maxPagesVisible ~/ 2;
    int start = (currentPage - half).clamp(1, totalPages - maxPagesVisible + 1);
    int end = (start + maxPagesVisible - 1).clamp(1, totalPages);
    start = (end - maxPagesVisible + 1).clamp(1, totalPages);

    final pages = <int?>[];
    if (start > 1) {
      pages.add(1);
      if (start > 2) pages.add(null); // ellipsis
    }
    for (var i = start; i <= end; i++) {
      pages.add(i);
    }
    if (end < totalPages) {
      if (end < totalPages - 1) pages.add(null); // ellipsis
      pages.add(totalPages);
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ??
          'Pagination: page $currentPage of $totalPages',
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // First
            if (showFirstLast)
              _PageButton(
                icon: Icons.first_page,
                isEnabled: currentPage > 1,
                onTap: () => onPageChanged(1),
                semanticLabel: 'First page',
              ),
            // Previous
            _PageButton(
              icon: Icons.chevron_left,
              isEnabled: currentPage > 1,
              onTap: () => onPageChanged(currentPage - 1),
              semanticLabel: 'Previous page',
            ),
            // Page numbers
            for (final p in _pages)
              p == null
                  ? const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: WidgetXSpacing.xxs),
                      child: Text('…'),
                    )
                  : _PageNumberButton(
                      page: p,
                      isActive: p == currentPage,
                      onTap: () => onPageChanged(p),
                    ),
            // Next
            _PageButton(
              icon: Icons.chevron_right,
              isEnabled: currentPage < totalPages,
              onTap: () => onPageChanged(currentPage + 1),
              semanticLabel: 'Next page',
            ),
            // Last
            if (showFirstLast)
              _PageButton(
                icon: Icons.last_page,
                isEnabled: currentPage < totalPages,
                onTap: () => onPageChanged(totalPages),
                semanticLabel: 'Last page',
              ),
          ],
        ),
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  const _PageButton({
    required this.icon,
    required this.isEnabled,
    required this.onTap,
    required this.semanticLabel,
  });

  final IconData icon;
  final bool isEnabled;
  final VoidCallback onTap;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Semantics(
      label: semanticLabel,
      button: true,
      enabled: isEnabled,
      child: IconButton(
        icon: Icon(icon, size: 18),
        onPressed: isEnabled ? onTap : null,
        color: isEnabled ? cs.onSurface : cs.onSurface.withValues(alpha: 0.38),
        padding: const EdgeInsets.all(WidgetXSpacing.xs),
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      ),
    );
  }
}

class _PageNumberButton extends StatelessWidget {
  const _PageNumberButton({
    required this.page,
    required this.isActive,
    required this.onTap,
  });

  final int page;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Semantics(
      label: 'Page $page${isActive ? ', current' : ''}',
      button: true,
      selected: isActive,
      child: AnimatedContainer(
        duration: WidgetXMotion.fast,
        margin: const EdgeInsets.symmetric(horizontal: WidgetXSpacing.xxs),
        child: Material(
          color: isActive ? cs.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          child: InkWell(
            onTap: isActive ? null : onTap,
            borderRadius: BorderRadius.circular(6),
            child: Container(
              constraints:
                  const BoxConstraints(minWidth: 36, minHeight: 36),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                  horizontal: WidgetXSpacing.sm, vertical: 6),
              child: Text(
                '$page',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: isActive ? cs.onPrimary : cs.onSurface,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
