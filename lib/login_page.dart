import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smes/service/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false; // State for password visibility
  final ApiService _apiService = ApiService();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Make the API call to login
        final response = await _apiService.postData('users/login', {
          "email": emailController.text,
          "password": passwordController.text,
        });

        // Check if the response contains the 'id' key
        if (response.containsKey('id')) {
          // Save user details in shared preferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('userId', response['id']);
          await prefs.setString('fullName', response['fullName']);
          await prefs.setString('phone', response['phone']);
          await prefs.setString('email', response['email']);
          await prefs.setString('role', response['role']);

          // Show a success message
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User login successfully!')),
            );
          }

          // Navigate to the appropriate dashboard based on the role
          final role = response['role'] as String;
          if (mounted) {
            if (role == 'SYSTEM_ADMINISTRATOR') {
              Navigator.pushReplacementNamed(context, '/system-admin-dashboard');
            } else if (role == 'SHOP_MANAGER') {
              Navigator.pushReplacementNamed(context, '/shop-manager-dashboard');
            } else if (role == 'CUSTOMER_ATTENDANT') {
              Navigator.pushReplacementNamed(context, '/customer-attendant-dashboard');
            } else {
              // Handle unknown role
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Unknown user role')),
              );
            }
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login failed: Invalid response format')),
            );
          }
        }
      } catch (error) {
        // Handle errors
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error login user: $error')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // You can add more email validation logic here if needed
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                    return 'Please enter your password';
                  }
                  // You can add more password validation logic here if needed
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgot-password');
                },
                child: const Text('Forgot Password?'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Don’t have an account? Register here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}