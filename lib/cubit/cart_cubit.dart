import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shopping_cart_app/models/product_model.dart';
import 'package:shopping_cart_app/models/cart_item_model.dart';

class CartCubit extends Cubit<List<CartItemModel>> {
  final Box cartBox = Hive.box('cartBox');

  CartCubit() : super([]) {
    loadCart();
  }

  void saveCart(List<CartItemModel> cart) {
    final data = cart.map((item) => item.toJson()).toList();

    cartBox.put('cart', data);
  }

  void loadCart() {
    final data = cartBox.get('cart');

    if (data != null) {
      final cart = (data as List).map((item) {
        return CartItemModel.fromJson(Map<String, dynamic>.from(
          item as Map,
        ));
      }).toList();

      emit(cart);
    }
  }

  void addProduct(ProductModel product, int quantity) {
    final index = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    final updatedCard = List<CartItemModel>.from(state);

    if (index == -1) {
      updatedCard.add(
        CartItemModel(
          product: product,
          quantity: quantity,
        ),
      );
    } else {
      updatedCard[index].quantity++;
    }
    saveCart(updatedCard);
    emit(updatedCard);
  }

  void increaseQuantity(CartItemModel cartItem) {
    final updatedCart = List<CartItemModel>.from(state);

    final index = updatedCart.indexWhere(
      (item) => item.product.id == cartItem.product.id,
    );

    if (index != -1) {
      updatedCart[index].quantity++;
      saveCart(updatedCart);
      emit(updatedCart);
    }
  }

  void decreaseQuantity(CartItemModel cartItem) {
    final updatedCart = List<CartItemModel>.from(state);

    final index = updatedCart.indexWhere(
      (item) => item.product.id == cartItem.product.id,
    );

    if (index != -1 && updatedCart[index].quantity > 1) {
      updatedCart[index].quantity--;
      saveCart(updatedCart);
      emit(updatedCart);
    }
  }

  void removeProduct(CartItemModel cartItem) {
    final updatedCart = List<CartItemModel>.from(state);

    final index = updatedCart.indexWhere(
      (item) => item.product.id == cartItem.product.id,
    );

    if (index != -1) {
      updatedCart.removeAt(index);
      saveCart(updatedCart);
      emit(updatedCart);
    }
  }

  void clearCart() {
    cartBox.delete('cart');
    saveCart([]);
    emit([]);
  }

  double get subtotal {
    double total = 0;

    for (var item in state) {
      total += item.product.price * item.quantity;
    }

    return total;
  }

  double get shipping {
    if (subtotal == 0) {
      return 0;
    }
    if (subtotal >= 100) {
      return 0;
    }
    return 10;
  }

  double get total {
    return subtotal + shipping;
  }
}
