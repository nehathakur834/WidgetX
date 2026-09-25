import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../../mock/mock_data.dart';
import '../../../providers/favorites_provider.dart';
import '../../../providers/cart_provider.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({super.key, this.product});
  final MockProduct? product;

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  String _selectedSize = 'M';
  int _quantity = 1;

  static const _sizes = ['XS', 'S', 'M', 'L', 'XL'];

  MockProduct get _product =>
      widget.product ?? MockData.products.first;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isFav = ref.watch(
      favoritesProvider.select((s) => s.contains('tpl-product')),
    );
    final cartQty = ref.watch(
      cartProvider.select((items) =>
          items.where((c) => c.product.id == _product.id).fold(0, (s, c) => s + c.quantity)),
    );
    final cartCount = ref.watch(cartCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/templates/ecommerce'),
        ),
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
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_outline,
              color: isFav ? Colors.red : null,
            ),
            tooltip: isFav ? 'Remove from favorites' : 'Add to favorites',
            onPressed: () =>
                ref.read(favoritesProvider.notifier).toggle('tpl-product'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _product.imageUrl.isNotEmpty
                        ? Image.network(
                            _product.imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) =>
                                progress == null
                                    ? child
                                    : Container(
                                        color: cs.surfaceContainerHighest,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: cs.outlineVariant,
                                          ),
                                        ),
                                      ),
                            errorBuilder: (context, error, e) => Container(
                              color: cs.surfaceContainerHighest,
                              child: Center(
                                child: Icon(Icons.image_outlined,
                                    size: 80, color: cs.outlineVariant),
                              ),
                            ),
                          )
                        : Container(
                            color: cs.surfaceContainerHighest,
                            child: Center(
                              child: Icon(Icons.image_outlined,
                                  size: 80, color: cs.outlineVariant),
                            ),
                          ),
                  ),
                  // Gallery indicator
                  Positioned(
                    bottom: 12, right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('1 / 4',
                          style: TextStyle(
                              color: Colors.white, fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                WidgetXSpacing.xl,
                WidgetXSpacing.xl,
                WidgetXSpacing.xl,
                WidgetXSpacing.xl + MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category chip
                  WidgetXChip(
                    label: _product.category,
                    isSelected: true,
                  ),
                  const SizedBox(height: WidgetXSpacing.sm),

                  // Title
                  Text(_product.name,
                      style: tt.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: WidgetXSpacing.sm),

                  // Price + Rating row
                  Row(
                    children: [
                      Text(
                        '\$${_product.price.toStringAsFixed(2)}',
                        style: tt.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: cs.primary,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.star,
                          size: 16, color: Colors.amber.shade600),
                      const SizedBox(width: 4),
                      Text(
                        '${_product.rating} (${_product.reviewCount} reviews)',
                        style: tt.bodyMedium
                            ?.copyWith(color: cs.onSurfaceVariant),
                      ),
                    ],
                  ),
                  const SizedBox(height: WidgetXSpacing.lg),

                  // Description
                  Text('Description',
                      style: tt.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: WidgetXSpacing.sm),
                  Text(
                    _product.description.isNotEmpty
                        ? _product.description
                        : 'A premium product crafted with care for everyday use.',
                    style: tt.bodyMedium
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(height: WidgetXSpacing.lg),

                  // Size selector
                  Text('Size',
                      style: tt.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: WidgetXSpacing.sm),
                  Wrap(
                    spacing: WidgetXSpacing.sm,
                    children: _sizes
                        .map(
                          (s) => ChoiceChip(
                            label: Text(s),
                            selected: _selectedSize == s,
                            onSelected: (_) =>
                                setState(() => _selectedSize = s),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: WidgetXSpacing.lg),

                  // Quantity row
                  Row(
                    children: [
                      Text('Quantity',
                          style: tt.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: cs.outlineVariant),
                          borderRadius: BorderRadius.circular(WidgetXRadius.sm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 18),
                              onPressed: _quantity > 1
                                  ? () => setState(() => _quantity--)
                                  : null,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: WidgetXSpacing.sm),
                              child: Text('$_quantity',
                                  style: tt.titleMedium),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, size: 18),
                              onPressed: () => setState(() => _quantity++),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: WidgetXSpacing.lg),

                  // In-cart indicator
                  if (cartQty > 0)
                    Container(
                      padding: const EdgeInsets.all(WidgetXSpacing.sm),
                      margin: const EdgeInsets.only(bottom: WidgetXSpacing.sm),
                      decoration: BoxDecoration(
                        color: cs.primaryContainer,
                        borderRadius: BorderRadius.circular(WidgetXRadius.sm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.shopping_cart,
                              size: 16, color: cs.onPrimaryContainer),
                          const SizedBox(width: WidgetXSpacing.sm),
                          Expanded(
                            child: Text(
                              '$cartQty already in cart',
                              style: tt.bodySmall?.copyWith(
                                  color: cs.onPrimaryContainer),
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                context.go('/templates/ecommerce/cart'),
                            child: Text('View',
                                style: TextStyle(
                                    color: cs.onPrimaryContainer)),
                          ),
                        ],
                      ),
                    ),

                  // CTA button
                  WidgetXButton(
                    label:
                        'Add to Cart — \$${(_product.price * _quantity).toStringAsFixed(2)}',
                    onPressed: () {
                      ref
                          .read(cartProvider.notifier)
                          .add(_product, quantity: _quantity);
                      showWidgetXSnackbar(
                        context: context,
                        message:
                            'Added $_quantity × ${_product.name} to cart',
                        variant: WidgetXSnackbarVariant.success,
                        actionLabel: 'View Cart',
                        onAction: () =>
                            context.go('/templates/ecommerce/cart'),
                      );
                    },
                    variant: WidgetXButtonVariant.primary,
                    isFullWidth: true,
                    leadingIcon: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 18),
                  ),
                  const SizedBox(height: WidgetXSpacing.sm),
                  WidgetXButton(
                    label: 'Add to Wishlist',
                    onPressed: () => ref
                        .read(favoritesProvider.notifier)
                        .toggle('product-${_product.id}'),
                    variant: WidgetXButtonVariant.outlined,
                    isFullWidth: true,
                    leadingIcon: Icon(
                      ref.watch(favoritesProvider.select(
                              (s) => s.contains('product-${_product.id}')))
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
