import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_app/cubit/product_cubit.dart';
import 'package:shopping_cart_app/cubit/product_state.dart';
import 'package:shopping_cart_app/models/category_model.dart';
import 'package:shopping_cart_app/widgets/product_card.dart';
import 'package:shopping_cart_app/widgets/shimmer_product_card.dart';

class CategoryProductsScreen extends StatelessWidget {
  final CategoryModel category;

  const CategoryProductsScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  child: Center(
                child: Text(state.message),
              ));
            }

            if (state is ProductsLoaded) {
              final products = state.products.where((product) {
                return product.category.toLowerCase() ==
                    category.apiName.toLowerCase();
              }).toList();

              if (products.isEmpty) {
                return const Center(
                  child: Text(
                    "No products found",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                );
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.60,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: products[index],
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
