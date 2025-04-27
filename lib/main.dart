import 'package:flutter/material.dart';
import 'package:flutter_getx_st/controller/initialization/initializtion.dart';
import 'package:flutter_getx_st/plugins/refresh/my_refresh_config.dart';
import 'package:flutter_getx_st/plugins/undefind/undefind_page.dart';
import 'package:flutter_getx_st/utils/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_st/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Initializtion.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) {
        return MyRefreshConfig(
          child: GetMaterialApp.router(
            debugShowCheckedModeBanner: false,
            unknownRoute: GetPage(
              name: "/404",
              page: () => const UndefindPage(),
            ),
            getPages: AppPages.routes,
            logWriterCallback: Logger.write,
            title: 'Flutter Getx 学习',
            enableLog: true,
            defaultTransition: Transition.rightToLeft,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
              useMaterial3: true,
            ),
          ),
        );
      },
    );
  }
}
