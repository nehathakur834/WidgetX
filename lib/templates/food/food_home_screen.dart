import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../../mock/mock_data.dart';
import '../../../catalog/template_app_bar.dart';

void _showRestaurantMenu(
    BuildContext context, MockRestaurant restaurant) {
  showWidgetXBottomSheet(
    context: context,
    title: restaurant.name,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${restaurant.cuisine} • ${restaurant.deliveryTime} • Min \$${restaurant.minOrder.toStringAsFixed(0)}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: WidgetXSpacing.md),
        Text('Menu',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: WidgetXSpacing.sm),
        for (final item in restaurant.menuItems)
          Padding(
            padding: const EdgeInsets.only(bottom: WidgetXSpacing.sm),
            child: Row(
              children: [
                if (item.isPopular)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .tertiaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('Popular',
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context)
                              .colorScheme
                              .onTertiaryContainer,
                        )),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500)),
                      Text(item.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant)),
                    ],
                  ),
                ),
                const SizedBox(width: WidgetXSpacing.md),
                Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(width: WidgetXSpacing.xs),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, size: 20),
                  onPressed: () {
                    Navigator.of(context).pop();
                    showWidgetXSnackbar(
                      context: context,
                      message: '${item.name} added to order',
                      variant: WidgetXSnackbarVariant.success,
                    );
                  },
                ),
              ],
            ),
          ),
        const SizedBox(height: WidgetXSpacing.md),
        WidgetXButton(
          label: 'Go to Restaurant',
          variant: WidgetXButtonVariant.primary,
          isFullWidth: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}

class FoodHomeScreen extends StatefulWidget {
  const FoodHomeScreen({super.key});

  @override
  State<FoodHomeScreen> createState() => _FoodHomeScreenState();
}

class _FoodHomeScreenState extends State<FoodHomeScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';

  static const _categories = [
    'All',
    'Pizza',
    'Sushi',
    'Burgers',
    'Salads',
    'Desserts',
    'Drinks',
  ];

  static const _restaurants = [
    _Restaurant(
        name: 'Pizzeria Napoli',
        cuisine: 'Italian',
        rating: 4.8,
        deliveryTime: '25-35 min',
        minOrder: 12.0,
        category: 'Pizza'),
    _Restaurant(
        name: 'Tokyo Garden',
        cuisine: 'Japanese',
        rating: 4.6,
        deliveryTime: '30-45 min',
        minOrder: 15.0,
        category: 'Sushi'),
    _Restaurant(
        name: 'Burger Republic',
        cuisine: 'American',
        rating: 4.5,
        deliveryTime: '20-30 min',
        minOrder: 8.0,
        category: 'Burgers'),
    _Restaurant(
        name: 'Green Bowl',
        cuisine: 'Healthy',
        rating: 4.7,
        deliveryTime: '20-25 min',
        minOrder: 10.0,
        category: 'Salads'),
    _Restaurant(
        name: 'Sweet Dreams',
        cuisine: 'Desserts',
        rating: 4.9,
        deliveryTime: '15-20 min',
        minOrder: 6.0,
        category: 'Desserts'),
    _Restaurant(
        name: 'The Juice Bar',
        cuisine: 'Beverages',
        rating: 4.4,
        deliveryTime: '10-15 min',
        minOrder: 5.0,
        category: 'Drinks'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final filtered = _selectedCategory == 'All'
        ? _restaurants
        : _restaurants.where((r) => r.category == _selectedCategory).toList();

    return Scaffold(
      appBar: const TemplateAppBar(
        title: 'Food Ordering',
        favoriteId: 'tpl-food',
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(WidgetXSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: cs.primary, size: 18),
                      const SizedBox(width: 4),
                      Text('San Francisco, CA',
                          style: tt.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      const Icon(Icons.keyboard_arrow_down, size: 18),
                    ],
                  ),
                  const SizedBox(height: WidgetXSpacing.sm),
                  Text('What are you craving?',
                      style: tt.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: WidgetXSpacing.md),
                  WidgetXTextField(
                    controller: _searchController,
                    hint: 'Search restaurants or dishes…',
                    prefixIcon: const Icon(Icons.search, size: 18),
                  ),
                  const SizedBox(height: WidgetXSpacing.lg),

                  // Promo banner
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange.shade400,
                          Colors.red.shade400,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(WidgetXRadius.lg),
                    ),
                    padding: const EdgeInsets.all(WidgetXSpacing.lg),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Free Delivery',
                                  style: tt.titleLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                              Text('On your first order!',
                                  style: tt.bodyMedium
                                      ?.copyWith(color: Colors.white70)),
                            ],
                          ),
                        ),
                        const Icon(Icons.delivery_dining,
                            size: 56, color: Colors.white54),
                      ],
                    ),
                  ),
                  const SizedBox(height: WidgetXSpacing.lg),

                  // Categories
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _categories
                          .map((c) => Padding(
                                padding: const EdgeInsets.only(
                                    right: WidgetXSpacing.sm),
                                child: ChoiceChip(
                                  label: Text(c),
                                  selected: _selectedCategory == c,
                                  onSelected: (_) =>
                                      setState(() => _selectedCategory = c),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: WidgetXSpacing.md),
                  Text('${filtered.length} restaurants',
                      style: tt.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: WidgetXSpacing.xl, vertical: WidgetXSpacing.sm),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => Padding(
                  padding: const EdgeInsets.only(bottom: WidgetXSpacing.md),
                  child: _RestaurantCard(restaurant: filtered[i]),
                ),
                childCount: filtered.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(
              child: SizedBox(height: WidgetXSpacing.xl)),
        ],
      ),
    );
  }
}

class _Restaurant {
  const _Restaurant({
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.deliveryTime,
    required this.minOrder,
    required this.category,
  });
  final String name, cuisine, deliveryTime, category;
  final double rating, minOrder;
}

class _RestaurantCard extends StatelessWidget {
  const _RestaurantCard({required this.restaurant});
  final _Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return WidgetXCard(
      onTap: () =>
          _showRestaurantMenu(context, MockData.restaurants.firstWhere(
            (r) => r.name == restaurant.name,
            orElse: () => MockData.restaurants.first,
          )),
      semanticDescription: 'View ${restaurant.name} menu',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(WidgetXRadius.sm),
            ),
            child: Center(
              child: Icon(Icons.restaurant,
                  size: 48, color: cs.outlineVariant),
            ),
          ),
          const SizedBox(height: WidgetXSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Text(restaurant.name,
                    style: tt.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ),
              Row(
                children: [
                  Icon(Icons.star,
                      size: 14, color: Colors.amber.shade600),
                  const SizedBox(width: 2),
                  Text('${restaurant.rating}',
                      style: tt.bodySmall),
                ],
              ),
            ],
          ),
          Text(restaurant.cuisine,
              style:
                  tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
          const SizedBox(height: WidgetXSpacing.xs),
          Row(
            children: [
              Icon(Icons.access_time_outlined,
                  size: 14, color: cs.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(restaurant.deliveryTime,
                  style:
                      tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
              const SizedBox(width: WidgetXSpacing.md),
              Text(
                  'Min order \$${restaurant.minOrder.toStringAsFixed(2)}',
                  style: tt.bodySmall
                      ?.copyWith(color: cs.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }
}
