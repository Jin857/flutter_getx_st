import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Second extends StatelessWidget {
  const Second({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页（Second）'),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_fire_department),
            onPressed: () async {
              // Get.rootDelegate.toNamed('/login');
              // Navigator.pushNamed(context, '/login'); // 使用命名路由
              // Get.offAllNamed('/login'); // 清空历史并导航到仪表板
              // Get.rootDelegate.popRoute();
              // Get.rootDelegate.backUntil("/login");
              // print(Get.rootDelegate.history.toString());
              // Get.rootDelegate.offAndToNamed(
              //   "/login",
              //   result: "/home",
              //   popMode: PopMode.Page,
              // );

              // Get.rootDelegate.popRoute();
              // Get.rootDelegate.canPopPage();
              // Get.rootDelegate.offNamed("/login");
              // Get.rootDelegate.canPopPage();

              // Get.rootDelegate.history.forEach((v) {
              //   print("--> ${v.currentPage}");
              // });
              // // await Get.rootDelegate.canPopPage();
              // Get.rootDelegate.offNamed("/login",);
              // Get.rootDelegate.history.forEach((v) {
              //   print("popRoute --> ${v.currentPage}");
              // });
              // await Get.rootDelegate.toNamed("/login");

              // Get.rootDelegate.pushHistory(
              //   GetNavConfig(
              //     currentTreeBranch: AppPages.routes,
              //     location: "/home/second",
              //     state: null,
              //   ),
              // );
              // Get.offAllNamed('/login');
              // Get.rootDelegate.offNamed("/login");
              // Get.offAllNamed("/login");
            },
          )
        ],
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: ElevatedButton(
            onPressed: () async {
              Get.rootDelegate.toNamed("/home/second/third");
            },
            child: const Text('下一页'),
          ),
        ),
      ),
    );
  }
}
