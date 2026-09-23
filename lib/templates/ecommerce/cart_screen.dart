import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../../../providers/favorites_provider.dart';
import '../../../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final cartItems = ref.watch(cartProvider);
    final isFav = ref.watch(
      favoritesProvider.select((s) => s.contains('tpl-cart')),
    );

    const shipping = 9.99;
    final subtotal =
        ref.read(cartProvider.notifier).subtotal;
    final total = subtotal + (cartItems.isNotEmpty ? shipping : 0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart (${cartItems.length})'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go('/templates/ecommerce'),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
              size: 20,
            ),
            tooltip: isFav ? 'Remove from favorites' : 'Add to favorites',
            onPressed: () =>
                ref.read(favoritesProvider.notifier).toggle('tpl-cart'),
          ),
          if (cartItems.isNotEmpty)
            TextButton(
              onPressed: () async {
                final confirmed = await showWidgetXConfirmDialog(
                  context: context,
                  title: 'Clear Cart',
                  message: 'Remove all items from your cart?',
                  confirmLabel: 'Clear',
                  isDestructive: true,
                );
                if (confirmed == true) {
                  ref.read(cartProvider.notifier).clear();
                }
              },
              child: const Text('Clear'),
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 64, color: cs.outlineVariant),
                  const SizedBox(height: WidgetXSpacing.md),
                  Text('Your cart is empty',
                      style: tt.titleMedium
                          ?.copyWith(color: cs.onSurfaceVariant)),
                  const SizedBox(height: WidgetXSpacing.sm),
                  WidgetXButton(
                    label: 'Continue Shopping',
                    variant: WidgetXButtonVariant.outlined,
                    onPressed: () =>
                        context.go('/templates/ecommerce'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(WidgetXSpacing.xl),
                    itemCount: cartItems.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: WidgetXSpacing.md),
                    itemBuilder: (_, i) {
                      final item = cartItems[i];
                      return WidgetXCard(
                        body: Row(
                          children: [
                            // Product image placeholder
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: cs.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(
                                    WidgetXRadius.md),
                              ),
                              child: Icon(Icons.image_outlined,
                                  color: cs.outlineVariant),
                            ),
                            const SizedBox(width: WidgetXSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(item.product.name,
                                      style: tt.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w500)),
                                  Text(item.product.category,
                                      style: tt.bodySmall?.copyWith(
                                          color: cs.onSurfaceVariant)),
                                  const SizedBox(
                                      height: WidgetXSpacing.xs),
                                  Text(
                                    '\$${item.product.price.toStringAsFixed(2)}',
                                    style: tt.titleSmall?.copyWith(
                                        color: cs.primary,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            // Qty controls
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: cs.outlineVariant),
                                    borderRadius:
                                        BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () => ref
                                            .read(cartProvider.notifier)
                                            .updateQuantity(
                                                item.product.id,
                                                item.quantity - 1),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                        child: const Padding(
                                          padding: EdgeInsets.all(6),
                                          child: Icon(Icons.remove,
                                              size: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text('${item.quantity}',
                                            style: tt.bodyMedium),
                                      ),
                                      InkWell(
                                        onTap: () => ref
                                            .read(cartProvider.notifier)
                                            .updateQuantity(
                                                item.product.id,
                                                item.quantity + 1),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                        child: const Padding(
                                          padding: EdgeInsets.all(6),
                                          child: Icon(Icons.add, size: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: WidgetXSpacing.xs),
                                InkWell(
                                  onTap: () => ref
                                      .read(cartProvider.notifier)
                                      .remove(item.product.id),
                                  child: Text('Remove',
                                      style: tt.labelSmall?.copyWith(
                                          color: cs.error)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Order summary
                Container(
                  padding: EdgeInsets.fromLTRB(
                    WidgetXSpacing.xl,
                    WidgetXSpacing.xl,
                    WidgetXSpacing.xl,
                    WidgetXSpacing.xl + MediaQuery.of(context).padding.bottom,
                  ),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    border: Border(
                        top: BorderSide(color: cs.outlineVariant)),
                    boxShadow: [
                      BoxShadow(
                        color: cs.shadow.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _SummaryRow(
                          label: 'Subtotal',
                          value: '\$${subtotal.toStringAsFixed(2)}'),
                      _SummaryRow(
                          label: 'Shipping',
                          value: '\$${shipping.toStringAsFixed(2)}'),
                      Divider(
                          height: WidgetXSpacing.lg,
                          color: cs.outlineVariant),
                      _SummaryRow(
                        label: 'Total',
                        value: '\$${total.toStringAsFixed(2)}',
                        isBold: true,
                      ),
                      const SizedBox(height: WidgetXSpacing.lg),
                      WidgetXButton(
                        label: 'Proceed to Checkout',
                        onPressed: () => _showCheckoutSuccess(context, ref),
                        variant: WidgetXButtonVariant.primary,
                        isFullWidth: true,
                        leadingIcon: const Icon(Icons.payment_outlined,
                            size: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void _showCheckoutSuccess(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.check_circle_outline,
            color: Colors.green, size: 48),
        title: const Text('Order Placed!'),
        content: const Text(
            'Your order has been placed successfully. '
            'You will receive a confirmation email shortly.'),
        actions: [
          FilledButton(
            onPressed: () {
              ref.read(cartProvider.notifier).clear();
              Navigator.of(ctx).pop();
              context.go('/templates/ecommerce');
            },
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow(
      {required this.label, required this.value, this.isBold = false});
  final String label, value;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isBold
                  ? tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)
                  : tt.bodyMedium),
          Text(value,
              style: isBold
                  ? tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)
                  : tt.bodyMedium),
        ],
      ),
    );
  }
}
