import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A searchable entry in the showcase catalogue.
class SearchEntry {
  const SearchEntry({
    required this.id,
    required this.label,
    required this.category,
    required this.route,
    required this.keywords,
  });

  final String id;
  final String label;
  final String category;
  final String route;
  final List<String> keywords;
}

// ---------------------------------------------------------------------------
// Full index of every component + template in the showcase
// ---------------------------------------------------------------------------
const _allEntries = <SearchEntry>[
  // ── Components ──────────────────────────────────────────────────────────
  SearchEntry(
    id: 'foundations',
    label: 'Foundations',
    category: 'Components',
    route: '/foundations',
    keywords: ['colors', 'typography', 'spacing', 'radius', 'design tokens', 'theme'],
  ),
  SearchEntry(
    id: 'buttons',
    label: 'Buttons',
    category: 'Components',
    route: '/buttons',
    keywords: ['button', 'fab', 'icon button', 'toggle', 'cta', 'action'],
  ),
  SearchEntry(
    id: 'inputs',
    label: 'Inputs',
    category: 'Components',
    route: '/inputs',
    keywords: ['input', 'text field', 'password', 'search', 'dropdown', 'checkbox', 'radio', 'switch', 'slider', 'otp', 'multi-select', 'form'],
  ),
  SearchEntry(
    id: 'cards',
    label: 'Cards',
    category: 'Components',
    route: '/cards',
    keywords: ['card', 'expandable', 'selectable', 'product card', 'stat card'],
  ),
  SearchEntry(
    id: 'navigation',
    label: 'Navigation',
    category: 'Components',
    route: '/navigation',
    keywords: ['navigation', 'bottom nav', 'nav rail', 'tab bar', 'breadcrumb', 'pagination', 'stepper', 'segmented'],
  ),
  SearchEntry(
    id: 'dialogs',
    label: 'Dialogs & Sheets',
    category: 'Components',
    route: '/dialogs',
    keywords: ['dialog', 'modal', 'bottom sheet', 'alert', 'confirmation', 'action sheet'],
  ),
  SearchEntry(
    id: 'feedback',
    label: 'Feedback',
    category: 'Components',
    route: '/feedback',
    keywords: ['snackbar', 'toast', 'banner', 'progress', 'skeleton', 'loader', 'avatar', 'badge', 'chip', 'empty state'],
  ),
  SearchEntry(
    id: 'data-display',
    label: 'Data Display',
    category: 'Components',
    route: '/data-display',
    keywords: ['table', 'list', 'timeline', 'accordion', 'badge', 'chip', 'avatar', 'divider', 'data', 'empty state'],
  ),
  SearchEntry(
    id: 'charts',
    label: 'Charts',
    category: 'Components',
    route: '/charts',
    keywords: ['chart', 'bar chart', 'line chart', 'area chart', 'pie chart', 'donut', 'radial', 'progress chart', 'graph', 'analytics'],
  ),
  SearchEntry(
    id: 'layout',
    label: 'Responsive Layout',
    category: 'Components',
    route: '/layout',
    keywords: ['layout', 'responsive', 'breakpoints', 'adaptive', 'grid', 'desktop', 'mobile', 'tablet'],
  ),
  SearchEntry(
    id: 'accessibility',
    label: 'Accessibility',
    category: 'Components',
    route: '/accessibility',
    keywords: ['accessibility', 'a11y', 'wcag', 'screen reader', 'semantics', 'contrast', 'focus', 'keyboard'],
  ),

  // ── Templates — Auth ────────────────────────────────────────────────────
  SearchEntry(
    id: 'tpl-welcome',
    label: 'Welcome Screen',
    category: 'Templates',
    route: '/templates/auth/welcome',
    keywords: ['welcome', 'splash', 'intro', 'brand', 'auth', 'get started'],
  ),
  SearchEntry(
    id: 'tpl-login',
    label: 'Login Screen',
    category: 'Templates',
    route: '/templates/auth/login',
    keywords: ['login', 'sign in', 'email', 'password', 'auth', 'authentication'],
  ),
  SearchEntry(
    id: 'tpl-register',
    label: 'Register Screen',
    category: 'Templates',
    route: '/templates/auth/register',
    keywords: ['register', 'sign up', 'create account', 'auth', 'form', 'password strength'],
  ),
  SearchEntry(
    id: 'tpl-forgot-password',
    label: 'Forgot Password',
    category: 'Templates',
    route: '/templates/auth/forgot-password',
    keywords: ['forgot password', 'reset password', 'auth', 'recovery', 'email'],
  ),
  SearchEntry(
    id: 'tpl-otp',
    label: 'OTP Verification',
    category: 'Templates',
    route: '/templates/auth/otp',
    keywords: ['otp', 'verification', '6 digit', 'code', 'auth', 'two factor', '2fa'],
  ),
  SearchEntry(
    id: 'tpl-onboarding',
    label: 'Onboarding',
    category: 'Templates',
    route: '/templates/auth/onboarding',
    keywords: ['onboarding', 'welcome', 'intro', 'splash', 'walkthrough'],
  ),

  // ── Templates — Dashboard ───────────────────────────────────────────────
  SearchEntry(
    id: 'tpl-dashboard',
    label: 'Analytics Dashboard',
    category: 'Templates',
    route: '/templates/dashboard',
    keywords: ['dashboard', 'analytics', 'kpi', 'stats', 'revenue', 'chart', 'admin'],
  ),

  // ── Templates — E-Commerce ──────────────────────────────────────────────
  SearchEntry(
    id: 'tpl-ecommerce',
    label: 'E-Commerce Home',
    category: 'Templates',
    route: '/templates/ecommerce',
    keywords: ['ecommerce', 'shop', 'store', 'product', 'catalog', 'grid'],
  ),
  SearchEntry(
    id: 'tpl-product',
    label: 'Product Details',
    category: 'Templates',
    route: '/templates/ecommerce/product',
    keywords: ['product', 'details', 'ecommerce', 'buy', 'cart', 'rating'],
  ),
  SearchEntry(
    id: 'tpl-cart',
    label: 'Shopping Cart',
    category: 'Templates',
    route: '/templates/ecommerce/cart',
    keywords: ['cart', 'checkout', 'order', 'ecommerce', 'basket'],
  ),

  // ── Templates — Finance ─────────────────────────────────────────────────
  SearchEntry(
    id: 'tpl-finance',
    label: 'Finance Dashboard',
    category: 'Templates',
    route: '/templates/finance',
    keywords: ['finance', 'wallet', 'balance', 'transactions', 'money', 'budget', 'expenses'],
  ),

  // ── Templates — Real Estate ─────────────────────────────────────────────
  SearchEntry(
    id: 'tpl-realestate',
    label: 'Property Listings',
    category: 'Templates',
    route: '/templates/realestate',
    keywords: ['real estate', 'property', 'listing', 'house', 'apartment', 'rent', 'buy'],
  ),
  SearchEntry(
    id: 'tpl-property-details',
    label: 'Property Details',
    category: 'Templates',
    route: '/templates/realestate/details',
    keywords: ['property', 'details', 'real estate', 'bedroom', 'bathroom'],
  ),

  // ── Templates — Social ──────────────────────────────────────────────────
  SearchEntry(
    id: 'tpl-social',
    label: 'Social Feed',
    category: 'Templates',
    route: '/templates/social',
    keywords: ['social', 'feed', 'post', 'story', 'like', 'comment', 'profile'],
  ),

  // ── Templates — Food ────────────────────────────────────────────────────
  SearchEntry(
    id: 'tpl-food',
    label: 'Food Ordering',
    category: 'Templates',
    route: '/templates/food',
    keywords: ['food', 'restaurant', 'delivery', 'menu', 'order', 'eat'],
  ),

  // ── Templates — Productivity ────────────────────────────────────────────
  SearchEntry(
    id: 'tpl-productivity',
    label: 'Task Dashboard',
    category: 'Templates',
    route: '/templates/productivity',
    keywords: ['task', 'todo', 'kanban', 'project', 'productivity', 'work', 'checklist'],
  ),

  // ── Templates — Portfolio ───────────────────────────────────────────────
  SearchEntry(
    id: 'tpl-portfolio',
    label: 'Portfolio',
    category: 'Templates',
    route: '/templates/portfolio',
    keywords: ['portfolio', 'developer', 'skills', 'projects', 'resume', 'contact'],
  ),

  // ── Templates — Booking ─────────────────────────────────────────────────
  SearchEntry(
    id: 'tpl-booking',
    label: 'Hotel Booking',
    category: 'Templates',
    route: '/templates/booking',
    keywords: ['booking', 'hotel', 'room', 'reservation', 'dates', 'check-in', 'check-out', 'guest'],
  ),

  // ── Templates — Settings ────────────────────────────────────────────────
  SearchEntry(
    id: 'tpl-settings',
    label: 'Settings',
    category: 'Templates',
    route: '/templates/settings',
    keywords: ['settings', 'account', 'profile', 'theme', 'notifications', 'privacy', 'appearance'],
  ),
];

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------

/// Returns entries that match the current [searchQueryProvider] value.
final searchResultsProvider = Provider<List<SearchEntry>>((ref) {
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  if (query.isEmpty) return const [];
  return _allEntries.where((e) {
    if (e.label.toLowerCase().contains(query)) return true;
    if (e.category.toLowerCase().contains(query)) return true;
    return e.keywords.any((k) => k.toLowerCase().contains(query));
  }).toList();
});

final searchQueryProvider = StateProvider<String>((ref) => '');
