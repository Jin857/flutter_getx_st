import 'package:flutter_getx_st/binding/home_binding.dart';
import 'package:flutter_getx_st/binding/login/login_binding.dart';
import 'package:flutter_getx_st/page/lobby/lobby_main.dart';
import 'package:flutter_getx_st/page/login/login.dart';
import 'package:flutter_getx_st/page/other/other.dart';
import 'package:flutter_getx_st/page/other/first.dart';
import 'package:flutter_getx_st/page/other/fourth.dart';
import 'package:flutter_getx_st/page/other/second.dart';
import 'package:flutter_getx_st/page/other/sixth.dart';
import 'package:flutter_getx_st/page/other/third.dart';
import 'package:flutter_getx_st/page/scan/scan_main.dart';
import 'package:flutter_getx_st/page/secondary/product/product_page.dart';
import 'package:flutter_getx_st/plugins/umeng/umeng_main.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      // 根导航器中的参与者
      name: Routes.LOBBY,
      page: () => const LobbyMain(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: Routes.PRODUCT,
          page: () => const ProductPage(),
        ),
        GetPage(
          name: Routes.SCANNER,
          page: () => const ScanMainPage(),
        ),
        GetPage(
          name: Routes.FIRST,
          page: () => First(),
        ),
        GetPage(
          name: Routes.SECEOND,
          page: () => const Second(),
          children: [
            GetPage(
              name: Routes.THIRD,
              page: () => const Third(),
            ),
            GetPage(
              name: Routes.FOURTH,
              page: () => const Fourth(),
            ),
          ],
        ),
      ],
    ),
    GetPage(
      name: Routes.OTHER,
      page: () => const OtherPage(),
      children: [
        GetPage(
          name: Routes.Sixth,
          page: () => const Sixth(),
        ),
      ],
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.UMENG,
      page: () => UmengMain(),
    ),
  ];
}
