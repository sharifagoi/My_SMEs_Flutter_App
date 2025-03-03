import 'package:flutter/material.dart';

class RecordSalesOptionsPage extends StatelessWidget {
  const RecordSalesOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Sales Options'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to New Sales page
                Navigator.pushNamed(context, '/new-sales');
              },
              child: const Text('New Sales'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Profit page
                Navigator.pushNamed(context, '/profit');
              },
              child: const Text('Profit'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Daily Sales page
                Navigator.pushNamed(context, '/daily-sales');
              },
              child: const Text('Daily Sales'),
            ),
          ],
        ),
      ),
    );
  }
}