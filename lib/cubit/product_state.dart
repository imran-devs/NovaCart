import 'package:shopping_cart_app/models/product_model.dart';

abstract class ProductState {}

class ProductsInitial extends ProductState{}

class ProductsLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<ProductModel> products;

  ProductsLoaded(this.products);
}

class ProductsError extends ProductState {
  final String message;
  
  ProductsError(this.message);
}