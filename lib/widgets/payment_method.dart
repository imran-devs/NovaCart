import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_app/cubit/payment_cubit.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, String>(
        builder: (context, selectedPayment) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.credit_card,
                ),
                SizedBox(width: 3),
                Text(
                  "Payment Method",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ],
            ),
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
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile(
                    title: const Text("Cash on Delivery"),
                    value: "COD",
                    groupValue: selectedPayment,
                    onChanged: (value) {
                      context.read<PaymentCubit>().changePayment(value!);
                    },
                  ),
                  const Divider(height: 18),
                  RadioListTile(
                    title: const Text("UPI"),
                    value: "UPI",
                    groupValue: selectedPayment,
                    onChanged: (value) {
                      context.read<PaymentCubit>().changePayment(value!);
                    },
                  ),
                  const Divider(height: 18),
                  RadioListTile(
                    title: const Text("Credit / Debit Card"),
                    value: "Card",
                    groupValue: selectedPayment,
                    onChanged: (value) {
                      context.read<PaymentCubit>().changePayment(value!);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
