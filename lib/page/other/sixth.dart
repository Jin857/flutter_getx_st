import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sixth extends StatelessWidget {
  const Sixth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('首页（Sixth）'),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: ElevatedButton(
            onPressed: () {
              Get.rootDelegate.backUntil("/other");
            },
            child: const Text('返回 other 页面'),
          ),
        ),
      ),
    );
  }
}
