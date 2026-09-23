import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../mock/mock_data.dart';

/// A single item in the shopping cart.
class CartItem {
  const CartItem({required this.product, required this.quantity});
  final MockProduct product;
  final int quantity;

  CartItem copyWith({int? quantity}) =>
      CartItem(product: product, quantity: quantity ?? this.quantity);
}

/// Cart state notifier — manages the in-memory cart.
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void add(MockProduct product, {int quantity = 1}) {
    final idx = state.indexWhere((c) => c.product.id == product.id);
    if (idx == -1) {
      state = [...state, CartItem(product: product, quantity: quantity)];
    } else {
      state = [
        for (final item in state)
          if (item.product.id == product.id)
            item.copyWith(quantity: item.quantity + quantity)
          else
            item,
      ];
    }
  }

  void remove(String productId) {
    state = state.where((c) => c.product.id != productId).toList();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      remove(productId);
      return;
    }
    state = [
      for (final item in state)
        if (item.product.id == productId)
          item.copyWith(quantity: quantity)
        else
          item,
    ];
  }

  void clear() => state = [];

  int quantityOf(String productId) =>
      state.where((c) => c.product.id == productId).fold(0, (s, c) => s + c.quantity);

  int get totalItems => state.fold(0, (s, c) => s + c.quantity);

  double get subtotal =>
      state.fold(0.0, (s, c) => s + c.product.price * c.quantity);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);

/// Derived — total item count badge.
final cartCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider.notifier).totalItems;
});

/// Derived — cart subtotal.
final cartSubtotalProvider = Provider<double>((ref) {
  ref.watch(cartProvider); // depend on changes
  return ref.read(cartProvider.notifier).subtotal;
});
