import 'package:flutter/material.dart';
import 'package:smes/service/api_service.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  void dispose() {
    _productNameController.dispose();
    _priceController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String productName = _productNameController.text;
      
      double price = double.parse(_priceController.text);
      String expiryDate = _expiryDateController.text;

      final response = await _apiService.postData('sales/product', {
        'name': productName,
        'price': price.toString(),
        'expiryDate': expiryDate,
      });

      if (mounted) {
        if (response.containsKey('id')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product added successfully!')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add product.')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _productNameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0), // Add spacing
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0), // Add spacing
              TextFormField(
                controller: _expiryDateController,
                decoration: const InputDecoration(labelText: 'Expiry Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiry date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Add spacing
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}