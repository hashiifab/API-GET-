import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

List<dynamic> products = [];

class _MyPageState extends State<MyPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Product',
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
            : GridView.count(
                childAspectRatio: 0.72,
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                shrinkWrap: true,
                children: List.generate(products.length, (index) {
                  final product = products[index];
                  final name = product['title'];
                  final price = product['price'];
                  final discount = '10%'; // Dummy discount
                  final imageURL = product['image'];

                  return InkWell(
                    onTap: () {
                      // Navigasi ke halaman detail produk jika diinginkan
                      Navigator.pushNamed(
                        context,
                        'itemsPage',
                        arguments: {
                          'productName': name,
                          'productDesc': product['description'],
                          'productPrice': '\$${price.toString()}',
                          'productDiscount': discount,
                          'productImage': imageURL,
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 14),
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF001F3F),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  discount,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.favorite_outline,
                                color: Colors.red,
                                size: 20,
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Image.network(
                              imageURL,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
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
                              product['description'] ?? '',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    // Ikon edit produk
                                    IconButton(
                                      onPressed: () {
                                        updateProduct(product['id']);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    // Ikon hapus produk
                                    IconButton(
                                      onPressed: () {
                                        deleteProduct(product['id']);
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
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addProduct();
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> fetchProducts() async {
    const url = 'https://fakestoreapi.com/products';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      products = json;
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Products loaded successfully!')),
    );
  }

  Future<void> addProduct() async {
    setState(() {
      isLoading = true;
    });

    const url = 'https://fakestoreapi.com/products';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode({
        'title': 'New Product',
        'price': 29.99,
        'description': 'A brand new product',
        'image': 'https://i.pravatar.cc',
        'category': 'electronics',
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      await fetchProducts(); // Refresh product list
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add product: ${response.body}')),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> updateProduct(int id) async {
    final url = 'https://fakestoreapi.com/products/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode({
        'title': 'Updated Product',
        'price': 19.99,
        'description': 'An updated product',
        'image': 'https://i.pravatar.cc',
        'category': 'electronics',
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      await fetchProducts(); // Refresh product list
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product updated successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update product: ${response.body}')),
      );
    }
  }

  Future<void> deleteProduct(int id) async {
    final url = 'https://fakestoreapi.com/products/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      await fetchProducts(); // Refresh product list
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete product: ${response.body}')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }
}
