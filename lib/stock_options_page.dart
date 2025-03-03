import 'package:flutter/material.dart';

class StockOptionsPage extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onStockDataLoaded;

  const StockOptionsPage({super.key, required this.onStockDataLoaded}); // Corrected: Use super.key

  @override
  StockOptionsPageState createState() => StockOptionsPageState();
}

class StockOptionsPageState extends State<StockOptionsPage> {
  List<Map<String, dynamic>> stock = [
    {'name': 'Product 1', 'quantity': 10},
    {'name': 'Product 2', 'quantity': 20},
    {'name': 'Product 3', 'quantity': 15},
  ];

  @override
  void initState() {
    super.initState();
    // Simulate fetching stock data (replace with your actual data fetching logic)
    _fetchStockData();
  }

  void _fetchStockData() {
    // Simulate fetching data after a delay
    Future.delayed(const Duration(seconds: 1), () {
      // Call the callback with the stock data
      widget.onStockDataLoaded(stock);
    });
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