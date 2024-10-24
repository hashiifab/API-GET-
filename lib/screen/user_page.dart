import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<dynamic> users = [];
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Page',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: users.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final name = user['first_name'] + " " + user['last_name'];
                final email = user['email'];
                final imageURL = user['avatar'];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(imageURL),
                  ),
                  title: Text(name),
                  subtitle: Text(email),
                );
              },
            ),
      /*  floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchUsers();
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.download,
          color: Colors.white,
        ),
      ), */
    );
  }

  void fetchUsers() async {
    const url = 'https://reqres.in/api/users?page=1';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['data'];
    });
  }
}
