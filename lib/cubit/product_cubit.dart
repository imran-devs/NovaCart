import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_app/cubit/product_state.dart';
import 'package:shopping_cart_app/models/product_model.dart';
import 'package:shopping_cart_app/services/api_service.dart';

class ProductCubit extends Cubit<ProductState> {
  final ApiService apiService;

  List<ProductModel> allProducts = [];

  ProductCubit(this.apiService) : super(ProductsInitial());

  Future<void> fetchProducts() async {
    try {
      emit(ProductsLoading());

      final products = await apiService.fetchProducts();

      allProducts = products;

      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      emit(ProductsLoaded(allProducts));
      return;
    }

    final filtered = allProducts.where((product) {
      return product.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(ProductsLoaded(filtered));
  }

  void filterByCategories(String category) {
    final filtered = allProducts.where((product) {
      return product.category.toLowerCase() == category.toLowerCase();
    }).toList();
    emit(ProductsLoaded(filtered));
  }
}
