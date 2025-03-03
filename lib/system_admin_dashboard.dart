import 'package:flutter/material.dart';
import 'package:smes/login_page.dart';
import 'package:smes/settings_page.dart';
import 'package:smes/update_profile_page.dart';
import 'package:smes/shop_manager_dashboard.dart';
import 'package:smes/customer_attendant_dashboard.dart'; // Import CustomerAttendantDashboard
import 'package:smes/home_page.dart'; // Import HomePage

class SystemAdminDashboard extends StatefulWidget {
  const SystemAdminDashboard({super.key});

  @override
  State<SystemAdminDashboard> createState() => _SystemAdminDashboardState();
}

class _SystemAdminDashboardState extends State<SystemAdminDashboard> {
  final List<Map<String, dynamic>> _stock = []; // Define _stock as final

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Admin Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle, size: 60, color: Colors.white),
                  SizedBox(height: 10),
                  Text('Admin Name',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text('admin@example.com',
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Navigate to Home page
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                        stock: _stock, // Pass _stock to HomePage
                      )),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Update Profile'),
              onTap: () {
                // Navigate to Update Profile page
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdateProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Manage Shop Managers'),
              onTap: () {
                // Navigate to Shop Manager Dashboard
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ShopManagerDashboard()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people_alt),
              title: const Text('Manage Customer Attendants'),
              onTap: () {
                // Navigate to Customer Attendant Dashboard
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomerAttendantDashboard()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to Settings page
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Navigate to Logout page
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('System Admin Dashboard Content'),
      ),
    );
  }
}