import 'package:flutter/material.dart';

class BusinessInsightsOptionsPage extends StatefulWidget {
  const BusinessInsightsOptionsPage({super.key});

  @override
  State<BusinessInsightsOptionsPage> createState() =>
      _BusinessInsightsOptionsPageState();
}

class _BusinessInsightsOptionsPageState
    extends State<BusinessInsightsOptionsPage> {
  int _shopCount = 1; // Default to one shop

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Insights Options'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'How many shops do you manage?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_shopCount > 1) {
                        _shopCount--;
                      }
                    });
                  },
                ),
                Text(
                  '$_shopCount',
                  style: const TextStyle(fontSize: 24),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _shopCount++;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            if (_shopCount > 1)
              ElevatedButton(
                onPressed: () {
                  // Navigate to Add Shop page
                  Navigator.pushNamed(context, '/add-shop');
                },
                child: const Text('Add Shop Details'),
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to Shop Insights page
                Navigator.pushNamed(context, '/shop-insights');
              },
              child: const Text('View Shop Insights'),
            ),
          ],
        ),
      ),
    );
  }
}