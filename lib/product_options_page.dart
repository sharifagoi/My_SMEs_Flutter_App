import 'package:flutter/material.dart';
import 'package:smes/add_product_page.dart'; // Import AddProductPage

class ProductOptionsPage extends StatefulWidget {
  const ProductOptionsPage({super.key});

  // Static list to hold products
  static final List<Map<String, dynamic>> products = [
    {'productName': 'Product A', 'price': 10.0, 'expiryDate': '2024-12-31'},
    {'productName': 'Product B', 'price': 20.0, 'expiryDate': '2025-01-15'},
    {'productName': 'Product C', 'price': 15.0, 'expiryDate': '2024-11-30'},
  ];

  @override
  State<ProductOptionsPage> createState() => _ProductOptionsPageState();
}

class _ProductOptionsPageState extends State<ProductOptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Options'),
      ),
      body: ListView.builder(
        itemCount: ProductOptionsPage.products.length,
        itemBuilder: (context, index) {
          final product = ProductOptionsPage.products[index];
          return ListTile(
            title: Text(product['productName']),
            subtitle: Text('Price: \$${product['price']}'),
            trailing: Text('Expiry: ${product['expiryDate']}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddProductPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}