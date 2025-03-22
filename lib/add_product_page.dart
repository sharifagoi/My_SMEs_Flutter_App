import 'package:flutter/material.dart';
import 'package:smes/service/api_service.dart';

class AddProductPage extends StatefulWidget {
  final Map<String, dynamic>? product;

  const AddProductPage({super.key, this.product});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _quantityController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _productNameController.text = widget.product!['name'];
      _priceController.text = widget.product!['price'].toString();
      _expiryDateController.text = widget.product!['expiryDate'];
      _quantityController.text = widget.product!['quantity'].toString();
    }
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _priceController.dispose();
    _expiryDateController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final productData = {
        'name': _productNameController.text,
        'price': double.parse(_priceController.text),
        'expiryDate': _expiryDateController.text,
        'quantity': int.parse(_quantityController.text),
      };

      try {
        if (widget.product != null) {
          await _apiService.updateData(
              '/products/${widget.product!['id']}', productData);
        } else {
          await _apiService.postData('products/add', productData);
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product saved successfully!')),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        _showError("Failed to save product");
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _productNameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter product name'
                    : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || double.tryParse(value) == null
                        ? 'Enter valid price'
                        : null,
              ),
              TextFormField(
                controller: _expiryDateController,
                decoration: const InputDecoration(labelText: 'Expiry Date'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter expiry date' : null,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || int.tryParse(value) == null
                        ? 'Enter valid quantity'
                        : null,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Save Product'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
