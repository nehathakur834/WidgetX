import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../../mock/mock_data.dart';
import '../../../catalog/template_app_bar.dart';
import '../../../providers/favorites_provider.dart';
import '../../../providers/cart_provider.dart';

class EcommerceHomeScreen extends ConsumerStatefulWidget {
  const EcommerceHomeScreen({super.key});

  @override
  ConsumerState<EcommerceHomeScreen> createState() =>
      _EcommerceHomeScreenState();
}

class _EcommerceHomeScreenState extends ConsumerState<EcommerceHomeScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';

  static const _categories = [
    'All',
    'Electronics',
    'Sports',
    'Accessories',
    'Health',
    'Office',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MockProduct> get _filtered {
    final query = _searchController.text.toLowerCase();
    var list = _selectedCategory == 'All'
        ? MockData.products
        : MockData.products
            .where((p) => p.category == _selectedCategory)
            .toList();
    if (query.isNotEmpty) {
      list = list
          .where((p) => p.name.toLowerCase().contains(query))
          .toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final cartCount = ref.watch(cartCountProvider);

    return Scaffold(
      appBar: TemplateAppBar(
        title: 'E-Commerce',
        favoriteId: 'tpl-ecommerce',
        actions: [
          IconButton(
            icon: Badge(
              isLabelVisible: cartCount > 0,
              label: Text('$cartCount'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            tooltip: 'View Cart',
            onPressed: () => context.go('/templates/ecommerce/cart'),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(WidgetXSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shop',
                      style: tt.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: WidgetXSpacing.md),
                  WidgetXTextField(
                    controller: _searchController,
                    hint: 'Search products…',
                    prefixIcon: const Icon(Icons.search, size: 18),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: WidgetXSpacing.lg),

                  // Featured banner
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [cs.primary, cs.secondary],
                      ),
                      borderRadius:
                          BorderRadius.circular(WidgetXRadius.lg),
                    ),
                    padding: const EdgeInsets.all(WidgetXSpacing.lg),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Summer Sale',
                                  style: tt.titleLarge?.copyWith(
                                      color: cs.onPrimary,
                                      fontWeight: FontWeight.w700)),
                              Text('Up to 50% off selected items',
                                  style: tt.bodyMedium
                                      ?.copyWith(color: cs.onPrimary)),
                              const SizedBox(height: WidgetXSpacing.sm),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: cs.onPrimary,
                                  side: BorderSide(color: cs.onPrimary),
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 6),
                                ),
                                child: const Text('Shop Now'),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.local_offer_outlined,
                            size: 64,
                            color: cs.onPrimary.withValues(alpha: 0.4)),
                      ],
                    ),
                  ),
                  const SizedBox(height: WidgetXSpacing.lg),

                  // Categories
                  Text('Categories',
                      style: tt.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: WidgetXSpacing.sm),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _categories
                          .map(
                            (c) => Padding(
                              padding: const EdgeInsets.only(
                                  right: WidgetXSpacing.sm),
                              child: ChoiceChip(
                                label: Text(c),
                                selected: _selectedCategory == c,
                                onSelected: (_) =>
                                    setState(() => _selectedCategory = c),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: WidgetXSpacing.lg),
                  Text('Products (${_filtered.length})',
                      style: tt.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: WidgetXSpacing.xl,
                vertical: WidgetXSpacing.sm),
            sliver: SliverGrid(
              gridDelegate:
                  const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: WidgetXSpacing.md,
                mainAxisSpacing: WidgetXSpacing.md,
                childAspectRatio: 0.68,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, i) => _ProductCard(product: _filtered[i]),
                childCount: _filtered.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
                height: WidgetXSpacing.xl +
                    MediaQuery.of(context).padding.bottom),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends ConsumerWidget {
  const _ProductCard({required this.product});
  final MockProduct product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final wishlistId = 'product-${product.id}';
    final isFav = ref.watch(
      favoritesProvider.select((s) => s.contains(wishlistId)),
    );
    final cartQty = ref.watch(
      cartProvider.select(
          (items) => items.where((c) => c.product.id == product.id).fold(0, (s, c) => s + c.quantity)),
    );

    return Semantics(
      label: 'View ${product.name} details',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cs.outlineVariant),
          color: cs.surface,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () => context.go('/templates/ecommerce/product',
                extra: product),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(WidgetXSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image placeholder with overlay
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(WidgetXRadius.sm),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(Icons.image_outlined,
                                size: 40, color: cs.outlineVariant),
                          ),
                          if (product.isNew)
                            Positioned(
                              top: 6, left: 6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: cs.primary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text('NEW',
                                    style: tt.labelSmall
                                        ?.copyWith(color: cs.onPrimary)),
                              ),
                            ),
                          if (product.isFeatured)
                            Positioned(
                              top: 6, left: 6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: cs.tertiary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text('HOT',
                                    style: tt.labelSmall
                                        ?.copyWith(color: cs.onTertiary)),
                              ),
                            ),
                          // Wishlist heart
                          Positioned(
                            top: 4, right: 4,
                            child: Semantics(
                              label: isFav
                                  ? 'Remove ${product.name} from wishlist'
                                  : 'Add ${product.name} to wishlist',
                              button: true,
                              child: InkWell(
                                onTap: () => ref
                                    .read(favoritesProvider.notifier)
                                    .toggle(wishlistId),
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: cs.surface.withValues(alpha: 0.9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 16,
                                    color: isFav
                                        ? Colors.red
                                        : cs.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: WidgetXSpacing.sm),
                  Text(product.name,
                      style: tt.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: WidgetXSpacing.xs),
                  Row(
                    children: [
                      Icon(Icons.star,
                          size: 12, color: Colors.amber.shade600),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                            '${product.rating} (${product.reviewCount})',
                            style: tt.labelSmall
                                ?.copyWith(color: cs.onSurfaceVariant)),
                      ),
                    ],
                  ),
                  const SizedBox(height: WidgetXSpacing.xs),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: tt.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: cs.primary)),
                      ),
                      // Add to cart button
                      Semantics(
                        label: cartQty > 0
                            ? '${product.name} in cart: $cartQty'
                            : 'Add ${product.name} to cart',
                        button: true,
                        child: InkWell(
                          onTap: () {
                            ref.read(cartProvider.notifier).add(product);
                            showWidgetXSnackbar(
                              context: context,
                              message: 'Added to cart',
                              variant: WidgetXSnackbarVariant.success,
                            );
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: cartQty > 0
                                  ? cs.primaryContainer
                                  : cs.primaryContainer
                                      .withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: cartQty > 0
                                ? Text('$cartQty',
                                    style: tt.labelMedium?.copyWith(
                                        color: cs.onPrimaryContainer,
                                        fontWeight: FontWeight.w700))
                                : Icon(Icons.add,
                                    size: 16,
                                    color: cs.onPrimaryContainer),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
