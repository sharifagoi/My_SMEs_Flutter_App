import 'package:flutter/material.dart';
import 'package:smes/service/api_service.dart';

class StockOptionsPage extends StatefulWidget {
  const StockOptionsPage({super.key});

  @override
  StockOptionsPageState createState() => StockOptionsPageState();
}

class StockOptionsPageState extends State<StockOptionsPage> {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> stock = [];

  @override
  void initState() {
    super.initState();
    _fetchStockData();
  }

  Future<void> _fetchStockData() async {
    final response = await _apiService.getData('sales/stock');
    if (response != null) {
      setState(() {
        stock = List<Map<String, dynamic>>.from(response);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Options'),
      ),
      body: ListView.builder(
        itemCount: stock.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(stock[index]['name']),
            subtitle: Text('Quantity: ${stock[index]['quantity']}'),
          );
        },
      ),
    );
  }
}
