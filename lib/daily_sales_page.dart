import 'package:flutter/material.dart';

class DailySalesPage extends StatelessWidget {
  const DailySalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Sales'),
      ),
      body: const Center(
        child: Text('Daily Sales Page Content'),
      ),
    );
  }
}