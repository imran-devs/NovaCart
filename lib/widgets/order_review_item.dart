import 'package:flutter/material.dart';
import 'package:shopping_cart_app/models/cart_item_model.dart';

class OrderReviewItem extends StatelessWidget {
  final CartItemModel cartItem;

  const OrderReviewItem({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 237, 232, 232),
                borderRadius: BorderRadius.circular(
                  12,
                )),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.network(
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                cartItem.product.thumbnail,
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItem.product.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  const Text(
                    "Qty: ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  Text(
                    cartItem.quantity.toString(),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "\$${cartItem.product.price}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    );
  }
}
