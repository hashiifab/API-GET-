import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api/screen/ujian/l_upadate.dart';
import 'package:flutter_api/screen/ujian/l_add.dart';
import 'package:flutter_api/screen/ujian/l_delete.dart';
import 'package:http/http.dart' as http;

class LatihanPage extends StatefulWidget {
  const LatihanPage({super.key});

  @override
  State<LatihanPage> createState() => LatihanPageState();
}

class LatihanPageState extends State<LatihanPage> {
  List<dynamic> products = [];
  bool isLoading = true; // Loading state variable
  String errorMessage = ''; // For error handling

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Latihan Page',
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : GridView.count(
                    childAspectRatio: 0.8,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    children: List.generate(products.length, (index) {
                      final product = products[index];
                      final name = product['title'];
                      final price = product['price'];
                      final description = product['description'];
                      final imageURL = product['image'];

                      return Container(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 14),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Image.network(
                                imageURL,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${price.toString()}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4C53A5),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const UpdateLatighanPage()));
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DeleteLatighanPage()));
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddLatighanPage()),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void fetchProducts() async {
    const url = 'https://fakestoreapi.com/products';
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        setState(() {
          products = json; // Update this line to assign the correct list
          isLoading = false; // Set loading to false after data is fetched
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load products: ${response.statusCode}';
          isLoading = false; // Set loading to false
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error occurred: $e'; // Handle exceptions
        isLoading = false; // Set loading to false
      });
    }
  }
}
