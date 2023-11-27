import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_flutter_app/repositories/product_repository.dart';
import 'package:my_first_flutter_app/stores/product_store.dart';
import 'package:my_first_flutter_app/http/http_client.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductStore productStore =
      ProductStore(repository: ProductRepository(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    productStore.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: AnimatedBuilder(
          animation: Listenable.merge([
            productStore.isLoading,
            productStore.products,
            productStore.errorMessage,
          ]),
          builder: (context, child) {
            if (productStore.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (productStore.errorMessage.value.isNotEmpty) {
              return Center(
                child: Text(productStore.errorMessage.value),
              );
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: productStore.products.value.length,
              itemBuilder: (context, index) {
                final item = productStore.products.value[index];

                return InkWell(
                  onTap: () {
                    context.push(
                      '/product-details/${item.id}',
                    );
                  },
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          color: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                item.title,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Image.network(
                                item.thumbnail,
                                height: 100,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                item.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'R\$ ${item.price}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
