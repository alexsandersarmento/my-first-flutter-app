import 'dart:convert';

import 'package:my_first_flutter_app/http/http_client.dart';
import 'package:my_first_flutter_app/models/product_model.dart';

abstract interface class IProductRepository {
  Future<List<ProductModel>> getProducts();
  Future addProduct(ProductModel product);
}

class ProductRepository implements IProductRepository {
  final IHttpClient client;
  final String url = 'https://dummyjson.com';

  ProductRepository({required this.client});

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get('$url/products');

    if (response.statusCode == 200) {
      final List<ProductModel> products = [];
      final body = jsonDecode(response.body);
      if (body.containsKey('products') && body['products'] is List) {
        final productList = body['products'] as List;

        for (var productJson in productList) {
          final product = ProductModel.fromMap(productJson);
          products.add(product);
        }

        return products;
      } else {
        throw Exception('Products key not found or is not a list in the response JSON.');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }
  
  @override
  Future<void> addProduct(ProductModel product) async {
    final body = jsonEncode(product.toMap());

    final response = await client.post('$url/products/add', data: body);

    print(response.statusCode);
  }
}