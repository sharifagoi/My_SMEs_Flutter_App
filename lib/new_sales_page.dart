import 'package:flutter/material.dart';

class NewSalesPage extends StatelessWidget {
  const NewSalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Sales'),
      ),
      body: const Center(
        child: Text('New Sales Page Content'),
      ),
    );
  }
}