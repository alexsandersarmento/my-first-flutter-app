import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final String id;

  const ProductDetailsPage({Key? key, required this.id}): super(key: key);

  static const routeName = 'product-details';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Product Details for ID: $id',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
