import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

class TemplatesScreen extends StatelessWidget {
  const TemplatesScreen({super.key});

  static const _templates = [
    _TemplateEntry(
      title: 'Welcome',
      subtitle: 'Branded splash with feature highlights and CTA',
      category: 'Auth',
      route: '/templates/auth/welcome',
      icon: Icons.waving_hand_outlined,
      color: Color(0xFF3B82F6),
    ),
    _TemplateEntry(
      title: 'Login',
      subtitle: 'Email + password, social login, remember me',
      category: 'Auth',
      route: '/templates/auth/login',
      icon: Icons.login_outlined,
      color: Color(0xFF3B82F6),
    ),
    _TemplateEntry(
      title: 'Register',
      subtitle: 'Full sign-up form with validation + strength meter',
      category: 'Auth',
      route: '/templates/auth/register',
      icon: Icons.person_add_outlined,
      color: Color(0xFF3B82F6),
    ),
    _TemplateEntry(
      title: 'Forgot Password',
      subtitle: 'Email input with success confirmation state',
      category: 'Auth',
      route: '/templates/auth/forgot-password',
      icon: Icons.lock_reset_outlined,
      color: Color(0xFF3B82F6),
    ),
    _TemplateEntry(
      title: 'OTP Verification',
      subtitle: '6-digit code input with animated success state',
      category: 'Auth',
      route: '/templates/auth/otp',
      icon: Icons.dialpad_outlined,
      color: Color(0xFF3B82F6),
    ),
    _TemplateEntry(
      title: 'Onboarding',
      subtitle: 'Three-step welcome flow with page indicators',
      category: 'Auth',
      route: '/templates/auth/onboarding',
      icon: Icons.rocket_launch_outlined,
      color: Color(0xFF3B82F6),
    ),
    _TemplateEntry(
      title: 'Analytics Dashboard',
      subtitle: 'KPI cards, bar chart, transactions table',
      category: 'Dashboard',
      route: '/templates/dashboard',
      icon: Icons.dashboard_outlined,
      color: Color(0xFF7C3AED),
    ),
    _TemplateEntry(
      title: 'E-Commerce Home',
      subtitle: 'Product grid, categories, featured items',
      category: 'E-Commerce',
      route: '/templates/ecommerce',
      icon: Icons.storefront_outlined,
      color: Color(0xFF10B981),
    ),
    _TemplateEntry(
      title: 'Product Details',
      subtitle: 'Image hero, ratings, add to cart action',
      category: 'E-Commerce',
      route: '/templates/ecommerce/product',
      icon: Icons.inventory_2_outlined,
      color: Color(0xFF10B981),
    ),
    _TemplateEntry(
      title: 'Shopping Cart',
      subtitle: 'Item list, quantity controls, order summary',
      category: 'E-Commerce',
      route: '/templates/ecommerce/cart',
      icon: Icons.shopping_cart_outlined,
      color: Color(0xFF10B981),
    ),
    _TemplateEntry(
      title: 'Finance Dashboard',
      subtitle: 'Balance card, spending categories, transactions',
      category: 'Finance',
      route: '/templates/finance',
      icon: Icons.account_balance_outlined,
      color: Color(0xFFF59E0B),
    ),
    _TemplateEntry(
      title: 'Property Listings',
      subtitle: 'Search, filter chips, property cards',
      category: 'Real Estate',
      route: '/templates/realestate',
      icon: Icons.home_work_outlined,
      color: Color(0xFFEF4444),
    ),
    _TemplateEntry(
      title: 'Property Details',
      subtitle: 'Gallery hero, specs, contact agent CTA',
      category: 'Real Estate',
      route: '/templates/realestate/details',
      icon: Icons.villa_outlined,
      color: Color(0xFFEF4444),
    ),
    _TemplateEntry(
      title: 'Social Feed',
      subtitle: 'Stories, post cards, likes and comments',
      category: 'Social',
      route: '/templates/social',
      icon: Icons.people_outline,
      color: Color(0xFF14B8A6),
    ),
    _TemplateEntry(
      title: 'Food Ordering',
      subtitle: 'Category chips, restaurant cards, menu items',
      category: 'Food',
      route: '/templates/food',
      icon: Icons.restaurant_outlined,
      color: Color(0xFFF97316),
    ),
    _TemplateEntry(
      title: 'Task Dashboard',
      subtitle: 'Kanban-style task board with priorities',
      category: 'Productivity',
      route: '/templates/productivity',
      icon: Icons.check_circle_outline,
      color: Color(0xFF8B5CF6),
    ),
    _TemplateEntry(
      title: 'Portfolio',
      subtitle: 'Skills, projects, contact section',
      category: 'Portfolio',
      route: '/templates/portfolio',
      icon: Icons.person_outline,
      color: Color(0xFF0EA5E9),
    ),
    _TemplateEntry(
      title: 'Hotel Booking',
      subtitle: 'Date picker, room selection, guest count, confirmation',
      category: 'Booking',
      route: '/templates/booking',
      icon: Icons.hotel_outlined,
      color: Color(0xFF0EA5E9),
    ),
    _TemplateEntry(
      title: 'Settings',
      subtitle: 'Account, appearance, notifications, about',
      category: 'Settings',
      route: '/templates/settings',
      icon: Icons.settings_outlined,
      color: Color(0xFF64748B),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Group by category
    final grouped = <String, List<_TemplateEntry>>{};
    for (final t in _templates) {
      grouped.putIfAbsent(t.category, () => []).add(t);
    }

    return Scaffold(
      appBar: const WidgetXAppBar(
        title: 'Templates',
        subtitle: '21 complete UI templates — all local, no backend',
      ),
      body: ListView(
        padding: const EdgeInsets.all(WidgetXSpacing.md),
        children: [
          const WidgetXBanner(
            variant: WidgetXBannerVariant.info,
            message:
                'Every template uses local MockData. Tap any card to see the '
                'full interactive screen.',
          ),
          const SizedBox(height: WidgetXSpacing.lg),
          for (final entry in grouped.entries) ...[
            Padding(
              padding: const EdgeInsets.only(
                bottom: WidgetXSpacing.sm,
                left: WidgetXSpacing.xs,
              ),
              child: Text(
                entry.key.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      letterSpacing: 0.8,
                    ),
              ),
            ),
            for (final t in entry.value)
              Padding(
                padding: const EdgeInsets.only(bottom: WidgetXSpacing.sm),
                child: _TemplateCard(template: t),
              ),
            const SizedBox(height: WidgetXSpacing.sm),
          ],
        ],
      ),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  const _TemplateCard({required this.template});
  final _TemplateEntry template;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return WidgetXCard(
      onTap: () => context.go(template.route),
      semanticDescription: 'Open ${template.title} template',
      body: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: template.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(WidgetXRadius.sm),
            ),
            child: Icon(template.icon, color: template.color, size: 22),
          ),
          const SizedBox(width: WidgetXSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  template.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  template.subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                  maxLines: 1,
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

class _TemplateEntry {
  const _TemplateEntry({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.route,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final String category;
  final String route;
  final IconData icon;
  final Color color;
}
