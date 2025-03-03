import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smes/service/api_service.dart';

class SetPasswordPage extends StatefulWidget {
  const SetPasswordPage({super.key});

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  bool _passwordVisible = false; // State for password visibility
  bool _confirmPasswordVisible = false; // State for confirm password visibility

  Future<void> _setPassword() async {
    if (_formKey.currentState!.validate()) {
      // Retrieve arguments from the previous page
      final Map<String, dynamic> args =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      // Access the registration details
      final String name = args['fullName'];
      final String phone = args['phone'];
      final String email = args['email'];
      final String role = args['role'];
      final String password = passwordController.text;

      try {
        // Make the API call to set the password
        final response = await _apiService.postData('users/password', {
          "email": email,
          "password": password,
        });

        // Check if the response contains the 'statusCode' key
        if (response.containsKey('statusCode')) {
          final statusCode = response['statusCode'] as int;

          if (statusCode == 200 || statusCode == 201) {
            // Show a success message
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password set successfully!')),
              );
            }

            // Use debugPrint for development logging
            if (kDebugMode) {
              debugPrint('Name: $name');
              debugPrint('Phone: $phone');
              debugPrint('Email: $email');
              debugPrint('Role: $role');
              debugPrint('Password: $password');
            }

            // Navigate to the login page after setting the password
            if (mounted) {
              Navigator.pushReplacementNamed(context, '/login');
            }
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'Set password failed with status code: $statusCode')),
              );
            }
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Set password failed: Invalid response format')),
            );
          }
        }
      } catch (error) {
        // Handle errors
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error set password: $error')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_passwordVisible, // Toggle visibility
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
              const SizedBox(height: 20),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_confirmPasswordVisible, // Toggle visibility
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _setPassword,
                child: const Text('Set Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}