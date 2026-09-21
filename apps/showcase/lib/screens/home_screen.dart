import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../shared/theme_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _categories = [
    _Category('Foundations', Icons.palette_outlined, '/foundations',
        'Colors, typography, spacing, radius, shadows, motion'),
    _Category('Buttons', Icons.smart_button_outlined, '/buttons',
        'Primary, secondary, outlined, text, destructive, icon, loading'),
    _Category('Inputs', Icons.input_outlined, '/inputs',
        'Text field, password, search, checkbox, radio, switch, slider, dropdown'),
    _Category('Cards', Icons.credit_card_outlined, '/cards',
        'Basic, info, statistic, expandable, selectable'),
    _Category('Feedback', Icons.notifications_outlined, '/feedback',
        'Snackbar, banners, progress, skeleton, empty state'),
    _Category('Layout', Icons.view_quilt_outlined, '/layout',
        'Responsive builder, container, breakpoints'),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = ThemeController.of(context);

    return Scaffold(
      appBar: WidgetXAppBar(
        title: 'WidgetX UI',
        subtitle: 'Design System Showcase',
        actions: [
          _ThemeSwitcher(
            mode: controller.themeMode,
            onChanged: controller.onThemeModeChanged,
          ),
        ],
      ),
      body: WidgetXResponsive(
        mobile: _MobileLayout(categories: _categories),
        tablet: _GridLayout(categories: _categories, columns: 2),
        desktop: _GridLayout(categories: _categories, columns: 3),
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.categories});
  final List<_Category> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(WidgetXSpacing.md),
      itemCount: categories.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: WidgetXSpacing.sm),
      itemBuilder: (_, i) => _CategoryTile(category: categories[i]),
    );
  }
}

class _GridLayout extends StatelessWidget {
  const _GridLayout({required this.categories, required this.columns});
  final List<_Category> categories;
  final int columns;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(WidgetXSpacing.md),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: WidgetXSpacing.sm,
        crossAxisSpacing: WidgetXSpacing.sm,
        childAspectRatio: 2.2,
      ),
      itemCount: categories.length,
      itemBuilder: (_, i) => _CategoryTile(category: categories[i]),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.category});
  final _Category category;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return WidgetXCard(
      onTap: () => Navigator.pushNamed(context, category.route),
      leading: Icon(category.icon, color: cs.primary, size: 28),
      title: Text(category.title),
      subtitle: Text(category.subtitle),
      semanticDescription: 'Navigate to ${category.title}',
    );
  }
}

class _ThemeSwitcher extends StatelessWidget {
  const _ThemeSwitcher({required this.mode, required this.onChanged});
  final ThemeMode mode;
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ThemeMode>(
      icon: Icon(_icon),
      tooltip: 'Switch theme',
      onSelected: onChanged,
      itemBuilder: (_) => [
        const PopupMenuItem(
            value: ThemeMode.light,
            child: Text('Light')),
        const PopupMenuItem(
            value: ThemeMode.dark,
            child: Text('Dark')),
        const PopupMenuItem(
            value: ThemeMode.system,
            child: Text('System')),
      ],
    );
  }

  IconData get _icon => switch (mode) {
        ThemeMode.light => Icons.light_mode,
        ThemeMode.dark => Icons.dark_mode,
        ThemeMode.system => Icons.brightness_auto,
      };
}

class _Category {
  const _Category(this.title, this.icon, this.route, this.subtitle);
  final String title;
  final IconData icon;
  final String route;
  final String subtitle;
}
