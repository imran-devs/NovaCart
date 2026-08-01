import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_app/cubit/cart_cubit.dart';

class CartSummary extends StatelessWidget {

  final String buttonText;
  final VoidCallback onPressed;
  
  const CartSummary({
    super.key, 
    required this.buttonText, 
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    final cartCubit = context.watch<CartCubit>();
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          )
        ]
      ),

      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const Text(
                "Subtotal",
              ),

              Text(
                "\$${cartCubit.subtotal.toStringAsFixed(2)}"
              )
            ],
          ),

          const SizedBox(height: 3),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const Text(
                "Shipping",
              ),

              Text(
                cartCubit.shipping == 0
                ? "Free"
                : "\$${cartCubit.shipping.toStringAsFixed(2)}",
              ),
            ],
          ),

          const Divider(
            height: 30,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const Text(
                "Total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              Text(
                "\$${cartCubit.total.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}