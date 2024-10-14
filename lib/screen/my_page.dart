import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

List<dynamic> products = [];
State<MyPage> createState() => _MyPageState();

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My product',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final name = product['title'];
          final price = product['price'];
          final imageURL = product['image'];
          return Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(imageURL),
                ),
                Text(name),
                Text(price.toString()),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchProducts();
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.download,
          color: Colors.white,
        ),
      ),
    );
  }

  void fetchProducts() async {
    const url = 'https://fakestoreapi.com/products';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      products = json;
    });
  }
}
