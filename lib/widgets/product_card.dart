import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_app/cubit/wishlist_cubit.dart';
import 'package:shopping_cart_app/models/product_model.dart';
import 'package:shopping_cart_app/screens/product_detail_screen.dart';
import 'package:shopping_cart_app/cubit/cart_cubit.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  final bool showFavourite;
  final bool showCartButton;

  const ProductCard({
    super.key,
    required this.product,
    this.showFavourite = true,
    this.showCartButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: context.read<CartCubit>(),
                child: ProductDetailScreen(
                  product: product,
                ),
              ),
            ));
      },
      child: Stack(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 18, 12, 8),
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "\$${product.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 18,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: BlocBuilder<WishlistCubit, List<ProductModel>>(
                    builder: (context, state) {
                  final isFavourite =
                      context.read<WishlistCubit>().isFavourite(product);
                  return IconButton(
                      onPressed: () {
                        context.read<WishlistCubit>().toggleWishlist(product);
                      },
                      icon: AnimatedScale(
                        scale: isFavourite ? 1.2 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        child: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                      ));
                }),
              )),
        ],
      ),
    );
  }
}
