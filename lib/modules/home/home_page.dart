import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventario_ifal/modules/home/home_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.find();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              controller.signOut();
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Home Page',
            ),
          ],
        ),
      ),
    );
  }
}
