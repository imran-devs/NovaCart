import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_app/cubit/address_cubit.dart';
import 'package:shopping_cart_app/cubit/cart_cubit.dart';
import 'package:shopping_cart_app/models/address_model.dart';
import 'package:shopping_cart_app/screens/success_screen.dart';
import 'package:shopping_cart_app/widgets/address_card.dart';
import 'package:shopping_cart_app/widgets/cart_summary.dart';
import 'package:shopping_cart_app/widgets/edit_address_bottom_sheet.dart';
import 'package:shopping_cart_app/widgets/order_review.dart';
import 'package:shopping_cart_app/widgets/payment_method.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Checkout",
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                BlocBuilder<AddressCubit, AddressModel>(
                  builder: (context, address) {
                    return AddressCard(
                      address: address,
                      onEdit: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) {
                            return EditAddressBottomSheet(
                              address: address,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                const PaymentMethod(),
                const SizedBox(height: 20),
                const OrderReview(),
              ],
            )),
            const SizedBox(height: 8),
            CartSummary(
              buttonText: "Place Order",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return AlertDialog(
                      title: const Text("Confirm Order"),
                      content: const Text(
                          "Are you sure you want to place your order?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                            },
                            child: const Text("Cancel")),
                        TextButton(
                          onPressed: () {
                            context.read<CartCubit>().clearCart();
                            Navigator.pop(dialogContext);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SuccessScreen()),
                                (route) => route.isFirst);
                          },
                          child: const Text("Place Order"),
                        ),
                      ],
                    );
                  },
                );
              },
            )
          ],
        )));
  }
}
