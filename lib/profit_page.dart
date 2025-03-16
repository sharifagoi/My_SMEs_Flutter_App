import 'package:flutter/material.dart';
import 'package:smes/service/api_service.dart';

class ProfitPage extends StatefulWidget {
  const ProfitPage({super.key});

  @override
  State<ProfitPage> createState() => _ProfitPageState();
}

class _ProfitPageState extends State<ProfitPage> {
  final ApiService _apiService = ApiService();
  double _totalProfit = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchProfit();
  }

  Future<void> _fetchProfit() async {
    final response = await _apiService.getData('sales/profit');
    if (response.containsKey('id')) {
      setState(() {
        _totalProfit = response['totalProfit'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profit'),
      ),
      body: Center(
        child: Text(
          'Total Profit: \$$_totalProfit',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
