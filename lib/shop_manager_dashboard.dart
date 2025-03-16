import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smes/business_insight_options_page.dart';
import 'package:smes/delete_options_page.dart';
import 'package:smes/home_page.dart';
import 'package:smes/login_page.dart';
import 'package:smes/product_options_page.dart';
import 'package:smes/record_sales_options_page.dart';
import 'package:smes/register_attendant_page.dart';
import 'package:smes/settings_page.dart';
import 'package:smes/stock_options_page.dart';
import 'package:smes/update_profile_page.dart'; // Import UpdateProfilePage

class ShopManagerDashboard extends StatefulWidget {
  const ShopManagerDashboard({super.key});

  @override
  State<ShopManagerDashboard> createState() => _ShopManagerDashboardState();
}

class _ShopManagerDashboardState extends State<ShopManagerDashboard> {
  List<Map<String, dynamic>> _stock = [];
  String? _fullName;
  String? _phone;
  String? _email;
  String? _role;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  void _loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _fullName = prefs.getString('fullName');
      _phone = prefs.getString('phone');
      _email = prefs.getString('email');
      _role = prefs.getString('role');
    });
  }

  void _updateStock(List<Map<String, dynamic>> newStock) {
    setState(() {
      _stock = newStock;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    stock: _stock,
                  )),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DeleteOptionsPage()),
        );
        break;
    }
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Update Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdateProfilePage()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.business),
              title: const Text('Business Insights'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const BusinessInsightsOptionsPage()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Register Customer Attendant'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterAttendantPage()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.point_of_sale),
              title: const Text('Record Sales'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RecordSalesOptionsPage()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Product'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductOptionsPage()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Stock'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StockOptionsPage()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text('User Details'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Full Name: ${_fullName ?? 'N/A'}'),
                  Text('Phone: ${_phone ?? 'N/A'}'),
                  Text('Email: ${_email ?? 'N/A'}'),
                  Text('Role: ${_role ?? 'N/A'}'),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Delete',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue,
        onTap: _onItemTapped,
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
