import 'package:flutter/material.dart';
import 'package:smes/home_page.dart';
import 'package:smes/product_options_page.dart';
import 'package:smes/stock_options_page.dart';
import 'package:smes/login_page.dart';
import 'package:smes/business_insight_options_page.dart';
import 'package:smes/register_attendant_page.dart';
import 'package:smes/record_sales_options_page.dart';
import 'package:smes/delete_options_page.dart';
import 'package:smes/settings_page.dart';
import 'package:smes/update_profile_page.dart'; // Import UpdateProfilePage

class ShopManagerDashboard extends StatefulWidget {
  const ShopManagerDashboard({super.key});

  @override
  State<ShopManagerDashboard> createState() => _ShopManagerDashboardState();
}

class _ShopManagerDashboardState extends State<ShopManagerDashboard> {
  List<Map<String, dynamic>> _stock = [];

  void _updateStock(List<Map<String, dynamic>> newStock) {
    setState(() {
      _stock = newStock;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Manager Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
        ],
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
                  Text('Manager Name',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text('manager@example.com',
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
                        stock: _stock,
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
              leading: const Icon(Icons.business),
              title: const Text('Business Insights'),
              onTap: () {
                // Navigate to Business Insights Options page
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BusinessInsightsOptionsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Register Customer Attendant'),
              onTap: () {
                // Navigate to Register Customer Attendant page
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterAttendantPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.point_of_sale),
              title: const Text('Record Sales'),
              onTap: () {
                // Navigate to Record Sales Options page
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RecordSalesOptionsPage()),
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
              leading: const Icon(Icons.inventory),
              title: const Text('Stock'),
              onTap: () {
                // Navigate to Stock Options page
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StockOptionsPage(
                        onStockDataLoaded: _updateStock,
                      )),
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
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                // Navigate to Delete Options page
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DeleteOptionsPage()),
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
        child: Text('Shop Manager Dashboard Content'),
      ),
    );
  }
}

// **Custom Search Delegate**
class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  String? get searchFieldLabel => 'Search for products';

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = ['Product A', 'Product B', 'Product C'];

    return ListView(
      children: suggestions
          .where((suggestion) =>
          suggestion.toLowerCase().contains(query.toLowerCase()))
          .map((suggestion) => ListTile(
        title: Text(suggestion),
        onTap: () {
          query = suggestion;
          showResults(context);
        },
      ))
          .toList(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search results for "$query"'),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }
}