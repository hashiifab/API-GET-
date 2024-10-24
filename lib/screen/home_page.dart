import 'package:flutter/material.dart';
import 'package:flutter_api/screen/add_user_page.dart';
import 'package:flutter_api/screen/delete_user_page.dart';
import 'package:flutter_api/screen/ujian/latihan.dart';
import 'package:flutter_api/screen/my_page.dart';
import 'package:flutter_api/screen/update_user_page.dart';
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
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
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
                child: const Text('API 1 (GET)',
                    style: TextStyle(color: Colors.black))),
            const SizedBox(
              height: 10,
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (context) {
            //         return const MyPage();
            //       }));
            //     },
            //     child: const Text('Latihan(GET)',
            //         style: TextStyle(color: Colors.black))),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AddUserPage();
                  }));
                },
                child: const Text('API 2 (POST)',
                    style: TextStyle(color: Colors.black))),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UpdateUserPage();
                  }));
                },
                child: const Text('API 3 (PUT)',
                    style: TextStyle(color: Colors.black))),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const DeleteUserPage();
                  }));
                },
                child: const Text('API 4 (DELETE)',
                    style: TextStyle(color: Colors.black))),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LatihanPage();
                  }));
                },
                child: const Text('Latihan',
                    style: TextStyle(color: Colors.black))),
          ],
        ),
      ),
    );
  }
}
