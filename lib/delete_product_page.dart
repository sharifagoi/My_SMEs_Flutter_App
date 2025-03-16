import 'package:flutter/material.dart';
import 'package:smes/service/api_service.dart';

class DeleteProductPage extends StatefulWidget {
  const DeleteProductPage({super.key});

  @override
  DeleteProductPageState createState() => DeleteProductPageState();
}

class DeleteProductPageState extends State<DeleteProductPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final data = await _apiService.getData('products');
      if (mounted) {
        setState(() {
          products = data;
        });
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _apiService.deleteData('delete/product/$id');
      if (mounted) {
        setState(() {
          products.removeWhere((product) => product['id'] == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product deleted successfully!')),
        );
      }
    } catch (e) {
      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting product: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Product'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product['name']),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                deleteProduct(product['id']);
              },
            ),
          );
        },
      ),
    );
  }
}
