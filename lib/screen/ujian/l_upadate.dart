import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateLatighanPage extends StatefulWidget {
  const UpdateLatighanPage({super.key});

  @override
  State<UpdateLatighanPage> createState() => UpdateLatighanPageState();
}

class UpdateLatighanPageState extends State<UpdateLatighanPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageURLController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update User Page',
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
                controller: idController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  labelText: 'ID',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: titleController,
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
                controller: priceController,
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
                controller: descriptionController,
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
                controller: imageURLController,
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
                  updateProduct(idController.text);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Update Product',
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

  Future<void> updateProduct(String productid) async {
    if (productid.isEmpty ||
        int.tryParse(productid) == null ||
        productid.length > 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Invalid Product ID, please enter a valid ID.')),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      var response = await http.put(
        Uri.parse('https://fakestoreapi.com/products/$productid'),
        body: {
          'title': titleController.text,
          'price': priceController.text,
          'description': descriptionController.text,
          'image': imageURLController.text,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Product updated: ${jsonResponse['title']}')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to update Prouct: ${response.body}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Occureded: $e')),
      );
    }
  }
}
