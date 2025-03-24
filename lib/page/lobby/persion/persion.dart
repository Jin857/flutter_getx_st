import 'package:flutter/widgets.dart';
import 'package:flutter_getx_st/controller/initialization/initializtion_controller.dart';
import 'package:flutter_getx_st/page/login/to_login.dart';
import 'package:get/get.dart';

class Persion extends StatelessWidget {
  Persion({super.key});
  final initializtionController = Get.find<InitializtionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => initializtionController.haseLogin.value
          ? Container(
              child: Text("ceshi"),
            )
          : const ToLogin(),
    );
  }
}
