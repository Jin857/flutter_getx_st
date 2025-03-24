import 'package:flutter/material.dart';
import 'package:flutter_getx_st/controller/initialization/initializtion_controller.dart';
import 'package:flutter_getx_st/routes/app_pages.dart';
import 'package:get/get.dart';

class First extends StatelessWidget {
  First({super.key});
  final InitializtionController controller =
      Get.find<InitializtionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('首页（First）'),
          actions: [
            IconButton(
              icon: const Icon(Icons.more),
              onPressed: () {
                Get.changeTheme(
                    context.isDarkMode ? ThemeData.light() : ThemeData.dark());
              },
            )
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await Get.rootDelegate
                          .offAndToNamed("${Routes.LOBBY}${Routes.SECEOND}");
                    },
                    child: const Text('下一页'),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
