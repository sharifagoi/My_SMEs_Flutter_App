import 'package:flutter/material.dart';
//import 'package:smes/stock_options_page.dart'; // Removed unused import

class HomePage extends StatefulWidget {
  final List<Map<String, dynamic>> stock;

  const HomePage({required this.stock, super.key}); // Moved key to super

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Dummy data for demonstration
  double _totalSales = 0.0;
  double _profit = 0.0;
  int _totalStock = 0;

  @override
  void initState() {
    super.initState();
    _calculateSummary();
  }

  void _calculateSummary() {
    // Calculate total stock
    // Access the stock list directly from StockOptionsPage
    // Get the state of StockOptionsPage

    final stock = widget.stock;
    _totalStock = stock.fold(0, (sum, item) => sum + item['quantity'] as int);

    // Calculate total sales and profit (dummy logic)
    // In a real app, you would fetch this from your sales data
    _totalSales = 15000.0; // Example total sales
    _profit = 5000.0; // Example profit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Total Sales Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.attach_money,
                        size: 40, color: Colors.green),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total Sales',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('$_totalSales',
                            style: const TextStyle(fontSize: 24)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Profit Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.trending_up,
                        size: 40, color: Colors.blue),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Profit',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('$_profit',
                            style: const TextStyle(fontSize: 24)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Total Stock Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.inventory,
                        size: 40, color: Colors.orange),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total Stock',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('$_totalStock',
                            style: const TextStyle(fontSize: 24)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}