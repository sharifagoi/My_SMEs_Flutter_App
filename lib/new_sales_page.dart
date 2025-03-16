import 'package:flutter/material.dart';
import 'package:smes/service/api_service.dart';

class NewSalesPage extends StatefulWidget {
  const NewSalesPage({super.key});

  @override
  State<NewSalesPage> createState() => _NewSalesPageState();
}

class _NewSalesPageState extends State<NewSalesPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _totalController = TextEditingController();
  final _dateController = TextEditingController();
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> _latestSales = [];

  @override
  void initState() {
    super.initState();
    _fetchLatestSales();
  }

  Future<void> _fetchLatestSales() async {
    final response = await _apiService.getData('sales/latest');
    if (response != null) {
      setState(() {
        _latestSales = List<Map<String, dynamic>>.from(response);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String quantity = _quantityController.text;
      String price = _priceController.text;
      String total = _totalController.text;
      String date = _dateController.text;

      final response = await _apiService.postData('sales/record', {
        'name': name,
        'quantity': quantity,
        'price': price,
        'total': total,
        'date': date,
      });

      if (response.containsKey('id')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sales recorded successfully!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to record sales.')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _totalController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Sales'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _totalController,
                decoration: const InputDecoration(labelText: 'Total'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the total';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Record Sales'),
              ),
              const SizedBox(height: 20),
              const Text('Latest Sales',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _latestSales.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_latestSales[index]['name']),
                    subtitle: Text(
                        'Quantity: ${_latestSales[index]['quantity']}, Total: ${_latestSales[index]['total']}'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
