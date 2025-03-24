import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Fourth extends StatelessWidget {
  const Fourth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('首页（Fourth）'),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: ElevatedButton(
            onPressed: () {
              Get.rootDelegate.backUntil("/home");
            },
            child: const Text('下一页'),
          ),
        ),
      ),
    );
  }
}
