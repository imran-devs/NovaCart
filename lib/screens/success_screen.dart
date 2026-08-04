import 'package:flutter/material.dart';
import 'package:shopping_cart_app/screens/main_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 70, right: 70),
            child: Image.asset(
              'assets/images/success.jpg',
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Order confirmed! 🎉",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          const Text(
            "Thank you for your purchase\nYour order is on its way!",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Continue Shopping",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
