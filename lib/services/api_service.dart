import 'dart:convert';
import 'package:shopping_cart_app/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<ProductModel>> fetchProducts() async {
    final response = await http
        .get(Uri.parse('https://dummyjson.com/products?limit=100'), headers: {
      'User-Agent': 'Mozilla/5.0',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final products = (data['products'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();

      return products;
    } else {
      throw Exception('Api failed');
    }
  }
}
