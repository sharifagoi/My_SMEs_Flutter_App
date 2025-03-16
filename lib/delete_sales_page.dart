import 'package:flutter/material.dart';
import 'package:smes/service/api_service.dart';

class DeleteSalesPage extends StatefulWidget {
  const DeleteSalesPage({super.key});

  @override
  DeleteSalesPageState createState() => DeleteSalesPageState();
}

class DeleteSalesPageState extends State<DeleteSalesPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> sales = [];

  @override
  void initState() {
    super.initState();
    fetchSales();
  }

  Future<void> fetchSales() async {
    try {
      final data = await _apiService.getData('sales');
      if (mounted) {
        setState(() {
          sales = data;
        });
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteSales(int id) async {
    try {
      await _apiService.deleteData('delete/sales/$id');
      if (mounted) {
        setState(() {
          sales.removeWhere((sale) => sale['id'] == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sales deleted successfully!')),
        );
      }
    } catch (e) {
      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting sales: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Sales'),
      ),
      body: ListView.builder(
        itemCount: sales.length,
        itemBuilder: (context, index) {
          final sale = sales[index];
          return ListTile(
            title: Text(sale['name']),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                deleteSales(sale['id']);
              },
            ),
          );
        },
      ),
    );
  }
}
