import 'package:flutter/material.dart';
import 'package:smes/service/api_service.dart';

class DeleteStockPage extends StatefulWidget {
  const DeleteStockPage({super.key});

  @override
  DeleteStockPageState createState() => DeleteStockPageState();
}

class DeleteStockPageState extends State<DeleteStockPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> stock = [];

  @override
  void initState() {
    super.initState();
    fetchStock();
  }

  Future<void> fetchStock() async {
    try {
      final data = await _apiService.getData('stock');
      if (mounted) {
        setState(() {
          stock = data;
        });
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteStock(int id) async {
    try {
      await _apiService.deleteData('delete/stock/$id');
      if (mounted) {
        setState(() {
          stock.removeWhere((item) => item['id'] == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Stock deleted successfully!')),
        );
      }
    } catch (e) {
      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting stock: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Stock'),
      ),
      body: ListView.builder(
        itemCount: stock.length,
        itemBuilder: (context, index) {
          final item = stock[index];
          return ListTile(
            title: Text(item['name']),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                deleteStock(item['id']);
              },
            ),
          );
        },
      ),
    );
  }
}
