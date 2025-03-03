import 'package:flutter/material.dart';
import 'package:smes/login_page.dart';
import 'package:smes/daily_sales_page.dart';
import 'package:smes/new_sales_page.dart';
import 'package:smes/product_options_page.dart';
import 'package:smes/settings_page.dart';
import 'package:smes/update_profile_page.dart';

class CustomerAttendantDashboard extends StatefulWidget {
  const CustomerAttendantDashboard({super.key});

  @override
  State<CustomerAttendantDashboard> createState() =>
      _CustomerAttendantDashboardState();
}

class _CustomerAttendantDashboardState
    extends State<CustomerAttendantDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Attendant Dashboard'),
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
                  Text('Attendant Name',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text('attendant@example.com',
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
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
              leading: const Icon(Icons.point_of_sale),
              title: const Text('Record Sales'),
              onTap: () {
                // Navigate to New Sales page
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NewSalesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Daily Sales'),
              onTap: () {
                // Navigate to Daily Sales page
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DailySalesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Product'),
              onTap: () {
                // Navigate to Product Options page
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductOptionsPage()),
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
        child: Text('Customer Attendant Dashboard Content'),
      ),
    );
  }
}