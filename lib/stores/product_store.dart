import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/models/product_model.dart';
import 'package:my_first_flutter_app/repositories/product_repository.dart';

class ProductStore {
  final IProductRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<ProductModel>> products = ValueNotifier<List<ProductModel>>([]);
  final ValueNotifier<String> errorMessage = ValueNotifier<String>('');

  ProductStore({required this.repository});

  Future getProducts() async {
    isLoading.value = true;

    try {
      final List<ProductModel> products = await repository.getProducts();
      this.products.value = products;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future addProduct(ProductModel product) async {
    isLoading.value = true;
    try {
      await repository.addProduct(product);
      // this.products.value = products;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}