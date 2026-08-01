import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_app/cubit/wishlist_cubit.dart';
import 'package:shopping_cart_app/models/product_model.dart';
import 'package:shopping_cart_app/screens/main_screen.dart';
import 'package:shopping_cart_app/widgets/wishlist_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          "My Wishlist",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<WishlistCubit, List<ProductModel>>(
        builder: (context, wishlist) {
          if (wishlist.isEmpty) {
            return SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 75, left: 50, right: 50),
                    child: Image.asset(
                      'assets/images/emptywishlist.jpg',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Your wishlist is empty",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Looks like you haven't added anything\nto your wishlist yet",
                    style: TextStyle(
                        fontSize: 16, color: Colors.grey, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              )),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                                (route) => false);
                          },
                          child: const Text(
                            "Continue Shopping",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72),
                itemCount: wishlist.length,
                itemBuilder: (context, index) {
                  return WishlistCard(
                    product: wishlist[index],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
