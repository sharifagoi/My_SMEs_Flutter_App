import 'package:flutter/material.dart';
import 'package:smes/service/api_service.dart';

class DeleteUserPage extends StatefulWidget {
  const DeleteUserPage({super.key});

  @override
  DeleteUserPageState createState() => DeleteUserPageState();
}

class DeleteUserPageState extends State<DeleteUserPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final data = await _apiService.getData('users');
      if (mounted) {
        setState(() {
          users = data;
        });
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await _apiService.deleteData('delete/user/$id');
      if (mounted) {
        setState(() {
          users.removeWhere((user) => user['id'] == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User deleted successfully!')),
        );
      }
    } catch (e) {
      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting user: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete User'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user['name']),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                deleteUser(user['id']);
              },
            ),
          );
        },
      ),
    );
  }
}
