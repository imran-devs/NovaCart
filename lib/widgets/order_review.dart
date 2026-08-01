import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_app/cubit/cart_cubit.dart';
import 'package:shopping_cart_app/models/cart_item_model.dart';
import 'package:shopping_cart_app/widgets/order_review_item.dart';

class OrderReview extends StatelessWidget {
  const OrderReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.shopping_bag_outlined,
            ),
            SizedBox(width: 4),
            Text(
              "Order Review",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            )
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                )
              ]),
          child: BlocBuilder<CartCubit, List<CartItemModel>>(
            builder: (context, cartItems) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      OrderReviewItem(cartItem: cartItems[index]),
                      if (index != cartItems.length - 1) const Divider()
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
