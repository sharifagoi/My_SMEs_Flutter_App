import 'package:flutter/material.dart';

class DeleteOptionsPage extends StatelessWidget {
  const DeleteOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Options'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Delete User page
                Navigator.pushNamed(context, '/delete-user');
              },
              child: const Text('Delete User'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Delete Product page
                Navigator.pushNamed(context, '/delete-product');
              },
              child: const Text('Delete Product'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Delete Sales page
                Navigator.pushNamed(context, '/delete-sales');
              },
              child: const Text('Delete Sales'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Delete Stock page
                Navigator.pushNamed(context, '/delete-stock');
              },
              child: const Text('Delete Stock'),
            ),
          ],
        ),
      ),
    );
  }
}