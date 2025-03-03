import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:smes/service/api_service.dart';

class RegisterAttendantPage extends StatefulWidget {
  const RegisterAttendantPage({super.key});

  @override
  State<RegisterAttendantPage> createState() => _RegisterAttendantPageState();
}

class _RegisterAttendantPageState extends State<RegisterAttendantPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  // Make the function async
  Future<void> _registerAttendant() async {
    if (_formKey.currentState!.validate()) {
      // Here you would typically send the registration data to a server
      // For this example, we'll just log the data conditionally
      _logRegistrationData(
        nameController.text,
        phoneController.text,
        emailController.text,
        passwordController.text,
        'CUSTOMER_ATTENDANT',
      );

      try {
        // Now await is allowed here
        final response = await _apiService.postData('users/register', {
          "fullName": nameController.text,
          "phone": phoneController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "role": 'CUSTOMER_ATTENDANT',
        });

        // Check if the response contains the 'statusCode' key
        if (response.containsKey('statusCode')) {
          final statusCode = response['statusCode'] as int;

          if (statusCode == 200 || statusCode == 201) {
            // Show a success message
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Attendant registered successfully!')),
              );
            }
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'Registration failed with status code: $statusCode')),
              );
            }
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Registration failed: Invalid response format')),
            );
          }
        }

        // Clear the form
        nameController.clear();
        phoneController.clear();
        emailController.clear();
        passwordController.clear();
      } catch (error) {
        // Handle errors
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error registering attendant: $error')),
          );
        }
      }
    }
  }

  void _logRegistrationData(
      String name,
      String phone,
      String email,
      String password,
      String role,
      ) {
    // Use dart:developer's log function for conditional logging
    developer.log('Name: $name', name: 'Registration');
    developer.log('Phone: $phone', name: 'Registration');
    developer.log('Email: $email', name: 'Registration');
    developer.log('Password: $password', name: 'Registration');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Customer Attendant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  // You can add more email validation logic here if needed
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _registerAttendant,
                child: const Text('Register Attendant'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}