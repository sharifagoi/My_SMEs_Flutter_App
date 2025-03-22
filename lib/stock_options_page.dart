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
    final response = await _apiService.getData('products/all');
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: stock.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Display in two columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2, // Adjust item size
                ),
                itemCount: stock.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            stock[index]['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Quantity: ${stock[index]['quantity']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
