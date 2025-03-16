import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smes/customer_attendant_dashboard.dart'; // Import CustomerAttendantDashboard
import 'package:smes/home_page.dart'; // Import HomePage
import 'package:smes/login_page.dart';
import 'package:smes/settings_page.dart';
import 'package:smes/shop_manager_dashboard.dart';
import 'package:smes/update_profile_page.dart';

class SystemAdminDashboard extends StatefulWidget {
  const SystemAdminDashboard({super.key});

  @override
  State<SystemAdminDashboard> createState() => _SystemAdminDashboardState();
}

class _SystemAdminDashboardState extends State<SystemAdminDashboard> {
  final List<Map<String, dynamic>> _stock = []; // Define _stock as final
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
                    stock: _stock, // Pass _stock to HomePage
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
        // Add any additional functionality for delete if needed
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Admin Dashboard'),
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
              leading: const Icon(Icons.people),
              title: const Text('Manage Shop Managers'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ShopManagerDashboard()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.people_alt),
              title: const Text('Manage Customer Attendants'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomerAttendantDashboard()),
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
