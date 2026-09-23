import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../catalog/section_header.dart';
import '../catalog/code_block.dart';
import '../catalog/favorite_button.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with SingleTickerProviderStateMixin {
  int _bottomNavIndex = 0;
  int _navRailIndex = 0;
  int _segmentIndex = 0;
  int _currentPage = 1;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static const _navItems = [
    WidgetXNavItem(
      icon: Icons.home_outlined,
      label: 'Home',
      activeIcon: Icons.home,
    ),
    WidgetXNavItem(
      icon: Icons.explore_outlined,
      label: 'Explore',
      activeIcon: Icons.explore,
    ),
    WidgetXNavItem(
      icon: Icons.person_outline,
      label: 'Profile',
      activeIcon: Icons.person,
    ),
  ];

  static const _railItems = [
    WidgetXNavRailItem(
      icon: Icons.dashboard_outlined,
      label: 'Dashboard',
      activeIcon: Icons.dashboard,
    ),
    WidgetXNavRailItem(
      icon: Icons.analytics_outlined,
      label: 'Analytics',
      activeIcon: Icons.analytics,
    ),
    WidgetXNavRailItem(
      icon: Icons.settings_outlined,
      label: 'Settings',
      activeIcon: Icons.settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const WidgetXAppBar(
        title: 'Navigation',
        actions: [FavoriteButton(id: 'navigation')],
      ),
      body: ListView(
        padding: const EdgeInsets.all(WidgetXSpacing.md),
        children: [
          // Tab Bar
          const SectionHeader(
            title: 'Tab Bar',
            description:
                'Use tabs for switching between peer content sections.',
          ),
          WidgetXCard(
            padding: EdgeInsets.zero,
            body: SizedBox(
              height: 140,
              child: Column(
                children: [
                  WidgetXTabBar(
                    tabs: const ['Overview', 'Details', 'Reviews'],
                    controller: _tabController,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        Center(child: Text('Overview content')),
                        Center(child: Text('Details content')),
                        Center(child: Text('Reviews content')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Segmented Control
          const SectionHeader(
            title: 'Segmented Control',
            description: 'Mutually exclusive single selection.',
          ),
          WidgetXSegmentedControl(
            segments: const ['Day', 'Week', 'Month'],
            selectedIndex: _segmentIndex,
            onChanged: (i) => setState(() => _segmentIndex = i),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Breadcrumbs
          const SectionHeader(title: 'Breadcrumbs'),
          WidgetXBreadcrumbs(
            items: [
              WidgetXBreadcrumbItem(label: 'Home', onTap: () {}),
              WidgetXBreadcrumbItem(label: 'Components', onTap: () {}),
              const WidgetXBreadcrumbItem(label: 'Navigation'),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Bottom Navigation preview
          const SectionHeader(
            title: 'Bottom Navigation Bar',
            description: 'Primary navigation for mobile apps.',
          ),
          WidgetXCard(
            padding: EdgeInsets.zero,
            body: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: WidgetXBottomNav(
                items: _navItems,
                selectedIndex: _bottomNavIndex,
                onDestinationSelected: (i) =>
                    setState(() => _bottomNavIndex = i),
              ),
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Navigation Rail preview
          const SectionHeader(
            title: 'Navigation Rail',
            description: 'Side navigation for tablet / desktop.',
          ),
          WidgetXCard(
            padding: EdgeInsets.zero,
            body: SizedBox(
              height: 220,
              child: Row(
                children: [
                  WidgetXNavRail(
                    items: _railItems,
                    selectedIndex: _navRailIndex,
                    onDestinationSelected: (i) =>
                        setState(() => _navRailIndex = i),
                  ),
                  VerticalDivider(width: 1, color: cs.outlineVariant),
                  Expanded(
                    child: Center(
                      child: Text(
                        _railItems[_navRailIndex].label,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Stepper
          const SectionHeader(
            title: 'Stepper',
            description: 'Multi-step process with progress tracking.',
          ),
          const WidgetXCard(
            padding: EdgeInsets.symmetric(vertical: WidgetXSpacing.sm),
            body: WidgetXStepper(
              physics: NeverScrollableScrollPhysics(),
              steps: [
                WidgetXStepItem(
                  title: 'Account',
                  subtitle: 'Create your account',
                  content: Text('Enter your email and password'),
                ),
                WidgetXStepItem(
                  title: 'Profile',
                  subtitle: 'Tell us about yourself',
                  content: Text('Add your name and bio'),
                ),
                WidgetXStepItem(
                  title: 'Review',
                  content: Text('Confirm your details'),
                ),
              ],
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Pagination
          const SectionHeader(
            title: 'Pagination',
            description: 'Navigate through multi-page data sets.',
          ),
          WidgetXCard(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Page $_currentPage of 12',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: WidgetXSpacing.sm),
                WidgetXPagination(
                  currentPage: _currentPage,
                  totalPages: 12,
                  onPageChanged: (p) => setState(() => _currentPage = p),
                ),
              ],
            ),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Code example
          const SectionHeader(title: 'Example Code'),
          const CodeBlock(
            code: '''WidgetXBottomNav(
  items: [
    WidgetXNavItem(icon: Icons.home, label: 'Home'),
    WidgetXNavItem(icon: Icons.person, label: 'Profile'),
  ],
  selectedIndex: _index,
  onDestinationSelected: (i) => setState(() => _index = i),
)''',
          ),
        ],
      ),
    );
  }
}
