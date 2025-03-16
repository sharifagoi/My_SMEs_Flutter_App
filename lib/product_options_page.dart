import 'package:flutter/material.dart';
import 'package:smes/add_product_page.dart'; // Import AddProductPage
import 'package:smes/service/api_service.dart';

class ProductOptionsPage extends StatefulWidget {
  const ProductOptionsPage({super.key});

  @override
  State<ProductOptionsPage> createState() => _ProductOptionsPageState();
}

class _ProductOptionsPageState extends State<ProductOptionsPage> {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final response = await _apiService.getData('sales/products');
    if (response.containsKey('id')) {
      setState(() {
        _products = List<Map<String, dynamic>>.from(response);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Options'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            title: Text(product['name']),
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
          ).then((_) =>
              _fetchProducts()); // Refresh products after adding a new one
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
