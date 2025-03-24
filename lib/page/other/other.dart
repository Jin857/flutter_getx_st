import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('其他'),
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
                child: const Text('返回Home'),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Get.rootDelegate.toNamed("/other/sixth");
                },
                child: const Text('下一页'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
