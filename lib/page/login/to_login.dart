import 'package:flutter/material.dart';
import 'package:flutter_getx_st/routes/app_pages.dart';
import 'package:get/get.dart';

class ToLogin extends StatelessWidget {
  const ToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          // Get.rootDelegate.offAndToNamed("/login");
          Get.rootDelegate.toNamed("${Routes.LOBBY}/${Routes.HREOA}");
        },
        child: Text("去登陆"),
      ),
    );
  }
}
