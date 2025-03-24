import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_getx_st/controller/initialization/initializtion_controller.dart';
import 'package:flutter_getx_st/controller/page/home_controller.dart';
import 'package:flutter_getx_st/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeFirstPage extends StatelessWidget {
  HomeFirstPage({super.key});
  final initializtionController = Get.find<InitializtionController>();
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.linearToSrgbGamma(),
          image: NetworkImage(
            "https://images.pexels.com/photos/3902882/pexels-photo-3902882.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
          ),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              initializtionController.obx((state) {
                return Column(
                  children: [
                    Text(
                      '我的文字大小在设计稿上是14px，不会随着系统的文字缩放比例变化',
                      style: TextStyle(
                          color: Colors.black,
                          // fontSize: 14,
                          fontSize: ScreenUtil().setSp(10)),
                    ),
                    const Center(
                      child: FittedBox(
                        child: Text(
                            'This is some very very very large text that is too big to fit a regular screen in a single line.'),
                      ),
                    ),
                    Center(
                      child: FittedBox(
                        child: Text(
                          'This is some very very very large text that is too',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: FittedBox(
                        child: Text(
                          'This is some very very very large text that is too big to fit a regular screen in a single line.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              Obx(
                () => Text(
                  'Count: ${controller.count}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Obx(
                () => Text(
                  'Home value: ${controller.value}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        initializtionController.updateUserInfo();
                      },
                      child: const Text('更新名称'),
                    ),
                  ]),
              Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.increment();
                      },
                      child: const Text('Home 数字添加'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.incrementValue();
                      },
                      child: const Text('Home value 数字添加'),
                    ),
                  ]),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.rootDelegate.offNamed(Routes.OTHER);
                    },
                    child: const Text('其他界面'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Get.rootDelegate
                          .toNamed("${Routes.LOBBY}${Routes.FIRST}");
                    },
                    child: const Text('下一页'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Get.rootDelegate.toNamed("/404");
                    },
                    child: const Text('404'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
