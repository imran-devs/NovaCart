import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shopping_cart_app/models/product_model.dart';

class WishlistCubit extends Cubit<List<ProductModel>> {
  final Box wishlistBox = Hive.box('wishlistBox');
  WishlistCubit() : super([]) {
    loadWishlist();
  }

  void saveWishlist(List<ProductModel> wishlist) {
    final data = wishlist.map((item) => item.toJson()).toList();

    wishlistBox.put('wishlist', data);
  }

  void loadWishlist() {
    final data = wishlistBox.get('wishlist');

    if (data != null) {
      final wishlist = (data as List).map((item) {
        return ProductModel.fromJson(Map<String, dynamic>.from(
          item as Map,
        ));
      }).toList();

      emit(wishlist.cast<ProductModel>());
    }
  }

  void toggleWishlist(ProductModel product) {
    final index = state.indexWhere(
      (item) => item.id == product.id,
    );

    final updatedWishlist = List<ProductModel>.from(state);

    if (index == -1) {
      updatedWishlist.add(product);
    } else {
      updatedWishlist.removeAt(index);
    }

    saveWishlist(updatedWishlist);
    emit(updatedWishlist);
  }

  bool isFavourite(ProductModel product) {
    return state.any(
      (item) => item.id == product.id,
    );
  }
}
