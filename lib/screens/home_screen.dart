import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_app/cubit/product_cubit.dart';
import 'package:shopping_cart_app/cubit/product_state.dart';
import 'package:shopping_cart_app/data/category_data.dart';
import 'package:shopping_cart_app/screens/all_products_screen.dart';
import 'package:shopping_cart_app/screens/categories_screen.dart';
import 'package:shopping_cart_app/screens/category_products_screen.dart';
import 'package:shopping_cart_app/widgets/category_card.dart';
import 'package:shopping_cart_app/widgets/product_card.dart';
import 'package:shopping_cart_app/widgets/shimmer_product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NovaCart",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            SearchBar(
              onChanged: (value) {
                context.read<ProductCubit>().searchProducts(value);
              },
              elevation: WidgetStateProperty.all(3),
              hintText: "Search products...",
              leading: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategoriesScreen()));
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 90,
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CategoryCard(
                      category: categories[index],
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryProductsScreen(
                                category: categories[index],
                              ),
                            ));
                      },
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Popular Products",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllProductsScreen(),
                          ));
                    },
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ))
              ],
            ),
            Expanded(child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.60,
                    ),
                    itemBuilder: (context, index) {
                      return const ShimmerProductCard();
                    },
                  );
                }

                if (state is ProductsError) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                if (state is ProductsLoaded) {
                  final products = state.products;

                  if (state.products.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 80),
                          SizedBox(height: 16),
                          Text(
                            "No products found",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Try another keyword",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.60,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: products[index],
                        showFavourite: true,
                        showCartButton: true,
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ))
          ],
        ),
      ),
    );
  }
}
