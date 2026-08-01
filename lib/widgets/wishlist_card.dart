import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_app/cubit/wishlist_cubit.dart';
import 'package:shopping_cart_app/models/product_model.dart';
import 'package:shopping_cart_app/screens/product_detail_screen.dart';
import 'package:shopping_cart_app/cubit/cart_cubit.dart';

class WishlistCard extends StatelessWidget {
  final ProductModel product;

  const WishlistCard({
    super.key,
    required this.product,
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
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
                    child: Hero(
                      tag: product.id,
                      child: Image.network(
                        product.thumbnail,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: 10,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "\$${product.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
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
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ));
                }),
              )),
        ],
      ),
    );
  }
}
