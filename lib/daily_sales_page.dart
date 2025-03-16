import 'package:flutter/material.dart';
import 'package:smes/service/api_service.dart';

class DailySalesPage extends StatefulWidget {
  const DailySalesPage({super.key});

  @override
  State<DailySalesPage> createState() => _DailySalesPageState();
}

class _DailySalesPageState extends State<DailySalesPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> _dailySales = [];

  @override
  void initState() {
    super.initState();
    _fetchDailySales();
  }

  Future<void> _fetchDailySales() async {
    final response = await _apiService.getData('sales/daily');
    if (response.containsKey('id')) {
      setState(() {
        _dailySales = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Sales'),
      ),
      body: ListView.builder(
        itemCount: _dailySales.length,
        itemBuilder: (context, index) {
          final sale = _dailySales[index];
          return ListTile(
            title: Text(sale['name']),
            subtitle:
                Text('Quantity: ${sale['quantity']}, Total: ${sale['total']}'),
            trailing: Text(sale['date']),
          );
        },
      ),
    );
  }
}
