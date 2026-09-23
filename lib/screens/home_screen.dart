import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../providers/recent_items_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const _categories = [
    _Category(
      title: 'Foundations',
      icon: Icons.palette_outlined,
      route: '/foundations',
      subtitle: 'Colors, typography, spacing, radius, shadows & motion',
      tag: 'Design Tokens',
    ),
    _Category(
      title: 'Buttons',
      icon: Icons.smart_button_outlined,
      route: '/buttons',
      subtitle:
          'Primary, secondary, outlined, text, destructive, icon & loading',
      tag: 'Interactive',
    ),
    _Category(
      title: 'Inputs',
      icon: Icons.input_outlined,
      route: '/inputs',
      subtitle:
          'Text fields, password, search, checkbox, radio, switch & slider',
      tag: 'Forms',
    ),
    _Category(
      title: 'Cards',
      icon: Icons.credit_card_outlined,
      route: '/cards',
      subtitle: 'Basic, info, statistic, expandable & selectable cards',
      tag: 'Layout',
    ),
    _Category(
      title: 'Dialogs & Sheets',
      icon: Icons.layers_outlined,
      route: '/dialogs',
      subtitle: 'Alert, confirmation, custom dialog & bottom sheets',
      tag: 'Overlay',
    ),
    _Category(
      title: 'Navigation',
      icon: Icons.compass_calibration_outlined,
      route: '/navigation',
      subtitle: 'App bar, bottom nav, rail, tab bar, breadcrumbs & stepper',
      tag: 'Navigation',
    ),
    _Category(
      title: 'Data Display',
      icon: Icons.table_chart_outlined,
      route: '/data-display',
      subtitle: 'Badges, chips, avatars, list tiles, timeline & data table',
      tag: 'Data',
    ),
    _Category(
      title: 'Feedback',
      icon: Icons.notifications_outlined,
      route: '/feedback',
      subtitle: 'Snackbar, banners, progress, skeleton & empty states',
      tag: 'Feedback',
    ),
    _Category(
      title: 'Charts',
      icon: Icons.bar_chart_outlined,
      route: '/charts',
      subtitle: 'Bar, line, area, pie & radial progress charts',
      tag: 'Charts',
    ),
    _Category(
      title: 'Layout',
      icon: Icons.view_quilt_outlined,
      route: '/layout',
      subtitle: 'Responsive builder, container & breakpoint utilities',
      tag: 'Responsive',
    ),
    _Category(
      title: 'Accessibility',
      icon: Icons.accessibility_new_outlined,
      route: '/accessibility',
      subtitle: 'Semantics, focus management, contrast & touch targets',
      tag: 'A11y',
    ),
    _Category(
      title: 'Templates',
      icon: Icons.grid_view_outlined,
      route: '/templates',
      subtitle: '21 complete UI templates — auth, e-commerce, finance & more',
      tag: 'Templates',
    ),
  ];

  static const _featuredTemplates = [
    _FeaturedTemplate(
      title: 'Analytics\nDashboard',
      icon: Icons.dashboard_outlined,
      color: Color(0xFF7C3AED),
      route: '/templates/dashboard',
    ),
    _FeaturedTemplate(
      title: 'Finance\nDashboard',
      icon: Icons.account_balance_outlined,
      color: Color(0xFFF59E0B),
      route: '/templates/finance',
    ),
    _FeaturedTemplate(
      title: 'Real Estate',
      icon: Icons.home_work_outlined,
      color: Color(0xFFEF4444),
      route: '/templates/realestate',
    ),
    _FeaturedTemplate(
      title: 'Hotel\nBooking',
      icon: Icons.hotel_outlined,
      color: Color(0xFF0EA5E9),
      route: '/templates/booking',
    ),
    _FeaturedTemplate(
      title: 'E-Commerce',
      icon: Icons.storefront_outlined,
      color: Color(0xFF10B981),
      route: '/templates/ecommerce',
    ),
    _FeaturedTemplate(
      title: 'Portfolio',
      icon: Icons.person_outline,
      color: Color(0xFF0EA5E9),
      route: '/templates/portfolio',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const WidgetXResponsive(
      mobile: _MobileLayout(
        categories: _categories,
        featured: _featuredTemplates,
      ),
      tablet: _TabletLayout(
        categories: _categories,
        featured: _featuredTemplates,
      ),
      desktop: _DesktopLayout(
        categories: _categories,
        featured: _featuredTemplates,
      ),
    );
  }
}

// ── Mobile: hero header + featured + card list ───────────────────────────────

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.categories, required this.featured});
  final List<_Category> categories;
  final List<_FeaturedTemplate> featured;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _HeroBanner()),
        SliverToBoxAdapter(child: _FeaturedSection(templates: featured)),
        SliverPadding(
          padding: const EdgeInsets.all(WidgetXSpacing.md),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => Padding(
                padding: const EdgeInsets.only(bottom: WidgetXSpacing.sm),
                child: _CategoryCard(category: categories[i]),
              ),
              childCount: categories.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: _Footer()),
      ],
    );
  }
}

// ── Tablet: hero header + featured + 2-column grid ───────────────────────────

class _TabletLayout extends StatelessWidget {
  const _TabletLayout({required this.categories, required this.featured});
  final List<_Category> categories;
  final List<_FeaturedTemplate> featured;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _HeroBanner()),
        SliverToBoxAdapter(child: _FeaturedSection(templates: featured)),
        SliverPadding(
          padding: const EdgeInsets.all(WidgetXSpacing.md),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: WidgetXSpacing.sm,
              crossAxisSpacing: WidgetXSpacing.sm,
              childAspectRatio: 2.4,
            ),
            delegate: SliverChildBuilderDelegate(
              (_, i) => _CategoryCard(category: categories[i]),
              childCount: categories.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: _Footer()),
      ],
    );
  }
}

// ── Desktop: sidebar + hero + featured + 3-column grid ───────────────────────

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.categories, required this.featured});
  final List<_Category> categories;
  final List<_FeaturedTemplate> featured;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Sidebar(categories: categories),
        VerticalDivider(
          width: 1,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _HeroBanner()),
              SliverToBoxAdapter(child: _FeaturedSection(templates: featured)),
              SliverPadding(
                padding: const EdgeInsets.all(WidgetXSpacing.md),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: WidgetXSpacing.sm,
                    crossAxisSpacing: WidgetXSpacing.sm,
                    childAspectRatio: 2.2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => _CategoryCard(category: categories[i]),
                    childCount: categories.length,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: _Footer()),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Sidebar ──────────────────────────────────────────────────────────────────

class _Sidebar extends StatelessWidget {
  const _Sidebar({required this.categories});
  final List<_Category> categories;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final currentRoute = GoRouterState.of(context).uri.path;

    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              WidgetXSpacing.md,
              WidgetXSpacing.md,
              WidgetXSpacing.md,
              WidgetXSpacing.sm,
            ),
            child: Text(
              'Components',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: cs.onSurfaceVariant,
                letterSpacing: 0.8,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: WidgetXSpacing.xs,
                vertical: 0,
              ),
              itemCount: categories.length,
              itemBuilder: (_, i) {
                final cat = categories[i];
                final isActive = currentRoute == cat.route;
                return Semantics(
                  selected: isActive,
                  child: InkWell(
                    onTap: () => context.go(cat.route),
                    borderRadius: BorderRadius.circular(8),
                    child: AnimatedContainer(
                      duration: WidgetXMotion.fast,
                      padding: const EdgeInsets.symmetric(
                        horizontal: WidgetXSpacing.sm,
                        vertical: WidgetXSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isActive
                            ? cs.primaryContainer
                            : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            cat.icon,
                            size: 18,
                            color: isActive
                                ? cs.onPrimaryContainer
                                : cs.onSurfaceVariant,
                          ),
                          const SizedBox(width: WidgetXSpacing.sm),
                          Expanded(
                            child: Text(
                              cat.title,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: isActive
                                        ? cs.onPrimaryContainer
                                        : cs.onSurface,
                                    fontWeight: isActive
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Hero banner ──────────────────────────────────────────────────────────────

class _HeroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(WidgetXSpacing.md),
      padding: const EdgeInsets.all(WidgetXSpacing.xl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cs.primaryContainer, cs.secondaryContainer],
        ),
        borderRadius: BorderRadius.circular(WidgetXRadius.lg),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(WidgetXSpacing.sm),
                decoration: BoxDecoration(
                  color: cs.primary,
                  borderRadius: BorderRadius.circular(WidgetXRadius.sm),
                ),
                child: Icon(
                  Icons.widgets_outlined,
                  color: cs.onPrimary,
                  size: 20,
                ),
              ).animate().fadeIn(duration: 350.ms).scaleXY(
                    begin: 0.85,
                    end: 1.0,
                    curve: Curves.easeOutBack,
                  ),
              const SizedBox(width: WidgetXSpacing.sm),
              Text(
                'WidgetX UI',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: cs.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                ),
              ).animate().fadeIn(delay: 60.ms, duration: 350.ms).slideX(
                    begin: -0.1,
                    end: 0,
                  ),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          Text(
            'A professional, open-source Flutter design system built for '
            'consistency, accessibility, and scalability.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: cs.onPrimaryContainer.withValues(alpha: 0.8),
            ),
          ).animate().fadeIn(delay: 120.ms, duration: 350.ms),
          const SizedBox(height: WidgetXSpacing.md),
          const Wrap(
            spacing: WidgetXSpacing.sm,
            runSpacing: WidgetXSpacing.sm,
            children: [
              _FeaturePill('Material 3'),
              _FeaturePill('Light & Dark'),
              _FeaturePill('Accessible'),
              _FeaturePill('Responsive'),
              _FeaturePill('Tested'),
            ],
          ).animate().fadeIn(delay: 200.ms, duration: 350.ms).slideY(
                begin: 0.15,
                end: 0,
              ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05, end: 0);
  }
}

class _FeaturePill extends StatelessWidget {
  const _FeaturePill(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: WidgetXSpacing.sm,
        vertical: WidgetXSpacing.xxs + 1,
      ),
      decoration: BoxDecoration(
        color: cs.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(WidgetXRadius.full),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: cs.onSurface),
      ),
    );
  }
}

// ── Category card ─────────────────────────────────────────────────────────────

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});
  final _Category category;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return WidgetXCard(
      onTap: () => context.go(category.route),
      semanticDescription: 'Navigate to ${category.title}',
      body: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(WidgetXRadius.sm),
            ),
            child: Icon(category.icon, color: cs.onPrimaryContainer, size: 22),
          ),
          const SizedBox(width: WidgetXSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        category.title,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: WidgetXSpacing.xs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: cs.secondaryContainer,
                        borderRadius: BorderRadius.circular(WidgetXRadius.xs),
                      ),
                      child: Text(
                        category.tag,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: cs.onSecondaryContainer,
                              fontSize: 10,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: WidgetXSpacing.xxs),
                Text(
                  category.subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: WidgetXSpacing.xs),
          Icon(Icons.arrow_forward_ios, size: 14, color: cs.onSurfaceVariant),
        ],
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(WidgetXSpacing.xl),
      child: Column(
        children: [
          const WidgetXDivider(),
          const SizedBox(height: WidgetXSpacing.md),
          Text(
            'WidgetX UI • MIT License • Built with Flutter & Material 3',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Data models ───────────────────────────────────────────────────────────────

class _Category {
  const _Category({
    required this.title,
    required this.icon,
    required this.route,
    required this.subtitle,
    required this.tag,
  });
  final String title;
  final IconData icon;
  final String route;
  final String subtitle;
  final String tag;
}

class _FeaturedTemplate {
  const _FeaturedTemplate({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
  final String title;
  final IconData icon;
  final Color color;
  final String route;
}

// ── Featured Templates section ────────────────────────────────────────────────

class _FeaturedSection extends ConsumerWidget {
  const _FeaturedSection({required this.templates});
  final List<_FeaturedTemplate> templates;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        WidgetXSpacing.md,
        0,
        WidgetXSpacing.md,
        WidgetXSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: WidgetXSpacing.sm,
              left: WidgetXSpacing.xs,
            ),
            child: Row(
              children: [
                Text(
                  'Featured Templates',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => context.go('/templates'),
                  child: const Text('View all'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: templates.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(width: WidgetXSpacing.sm),
              itemBuilder: (_, i) =>
                  _FeaturedTemplateCard(template: templates[i]),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 250.ms, duration: 350.ms).slideY(
          begin: 0.08,
          end: 0,
        );
  }
}

class _FeaturedTemplateCard extends ConsumerWidget {
  const _FeaturedTemplateCard({required this.template});
  final _FeaturedTemplate template;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        ref.read(recentItemsProvider.notifier).record(
              RecentItem(
                id: template.route,
                label: template.title.replaceAll('\n', ' '),
                route: template.route,
              ),
            );
        context.go(template.route);
      },
      borderRadius: BorderRadius.circular(WidgetXRadius.md),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: template.color.withValues(alpha: 0.1),
          border: Border.all(
            color: template.color.withValues(alpha: 0.25),
          ),
          borderRadius: BorderRadius.circular(WidgetXRadius.md),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: template.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(WidgetXRadius.sm),
              ),
              child: Icon(template.icon, color: template.color, size: 20),
            ),
            const SizedBox(height: WidgetXSpacing.xs),
            Text(
              template.title,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
