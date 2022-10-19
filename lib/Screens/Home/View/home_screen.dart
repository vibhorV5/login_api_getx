import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: Get.width,
          height: Get.height * 0.9,
          color: Colors.amber,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(50),
            child: const Text(
              'WELCOME TO HOME SCREEN',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
