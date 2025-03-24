import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToLogin extends StatelessWidget {
  const ToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Get.rootDelegate.offAndToNamed("/login");
        },
        child: Text("去登陆"),
      ),
    );
  }
}
