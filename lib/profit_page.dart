import 'package:flutter/material.dart';

class ProfitPage extends StatelessWidget {
  const ProfitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profit'),
      ),
      body: const Center(
        child: Text('Profit Page Content'),
      ),
    );
  }
}