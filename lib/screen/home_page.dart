import 'package:flutter/material.dart';
import 'package:flutter_api/screen/my_page.dart';
import 'package:flutter_api/screen/user_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UserPage();
                  }));
                },
                child:
                    const Text('API 1', style: TextStyle(color: Colors.black))),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return  MyPage();
                  }));
                },
                child:
                    const Text('API 2', style: TextStyle(color: Colors.black))),
          ],
        ),
      ),
    );
  }
}
