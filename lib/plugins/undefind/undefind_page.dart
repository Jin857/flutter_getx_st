import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UndefindPage extends StatelessWidget {
  const UndefindPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('404'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Get.rootDelegate.offNamed("/home");
                },
                child: const Text('404\n返回Home'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
