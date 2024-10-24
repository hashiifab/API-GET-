// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  String name = '';
  String email = '';
  String imageURL = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add User Page',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) => name = value,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) => email = value,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) => imageURL = value,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: addUser,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Add User',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    )
            ],
          )),
    );
  }

  Future<void> addUser() async {
    setState(() => isLoading = true);
    try {
      var response = await http.post(
        Uri.parse('https://reqres.in/api/users'),
        body: {
          'name': name,
          'email': email,
          'avatar': imageURL,
        },
      );

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User added: ${jsonResponse['name']}')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add user: ${response.body}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Occureded: $e')),
      );
    }
    setState(() => isLoading = false);
  }
}
