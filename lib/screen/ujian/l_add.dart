import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddLatighanPage extends StatefulWidget {
  const AddLatighanPage({super.key});

  @override
  State<AddLatighanPage> createState() => AddLatighanPageState();
}

class AddLatighanPageState extends State<AddLatighanPage> {
  String name = '';
  String productDescription = '';
  String productPrice = '';
  String imageURL = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Product Page',
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
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  labelText: 'Name',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) => productPrice = value,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  labelText: 'Price',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) => productDescription = value,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  labelText: 'Description',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) => imageURL = value,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  labelText: 'Image URL',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  addProducts();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Add Product',
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

  Future<void> addProducts() async {
    setState(() => isLoading = true);
    try {
      var response = await http.post(
        Uri.parse('https://fakestoreapi.com/products'),
        body: {
          'title': name,
          'price': productPrice,
          'description': productDescription,
          'image': imageURL,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product added: ${jsonResponse['title']}')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add product: ${response.body}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Occureded: $e')),
      );
    }
    setState(() => isLoading = false);
  }
}
