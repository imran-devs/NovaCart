import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_app/cubit/product_cubit.dart';
import 'package:shopping_cart_app/cubit/product_state.dart';
import 'package:shopping_cart_app/widgets/product_card.dart';
import 'package:shopping_cart_app/widgets/shimmer_product_card.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  String selectedSort = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SafeArea(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text("Price: Low to High"),
                          onTap: () {
                            setState(() {
                              selectedSort = "lowToHigh";
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text("Price: High to Low"),
                          onTap: () {
                            setState(() {
                              selectedSort = "highToLow";
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text("Rating"),
                          onTap: () {
                            setState(() {
                              selectedSort = "rating";
                            });
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ));
                  },
                );
              },
              icon: const Icon(Icons.sort))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.60,
                ),
                itemBuilder: (context, index) {
                  return const ShimmerProductCard();
                },
              );
            }
            if (state is ProductsError) {
              return Center(
                child: Text(
                  state.message,
                ),
              );
            }

            if (state is ProductsLoaded) {
              final products = List.of(state.products);

              if (selectedSort == "lowToHigh") {
                products.sort((a, b) => a.price.compareTo(b.price));
              }

              if (selectedSort == "highToLow") {
                products.sort((a, b) => b.price.compareTo(a.price));
              }

              if (selectedSort == "rating") {
                products.sort((a, b) => b.rating.compareTo(a.rating));
              }

              if (products.isEmpty) {
                return const Center(
                  child: Text("No products available"),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<ProductCubit>().fetchProducts();
                },
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.60,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: products[index],
                      showFavourite: true,
                      showCartButton: true,
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
