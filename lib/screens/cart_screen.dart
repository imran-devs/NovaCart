import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_app/cubit/cart_cubit.dart';
import 'package:shopping_cart_app/models/cart_item_model.dart';
import 'package:shopping_cart_app/screens/checkout_screen.dart';
import 'package:shopping_cart_app/widgets/cart_item_card.dart';
import 'package:shopping_cart_app/widgets/cart_summary.dart';
import 'package:shopping_cart_app/widgets/empty_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 3,
        title: const Text(
          "My Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CartCubit, List<CartItemModel>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) {
            return const EmptyCart();
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return CartItemCard(
                      cartItem: cartItems[index],
                    );
                  },
                ),
              ),
              CartSummary(
                buttonText: 'Proceed to Checkout',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckoutScreen(),
                      ));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
