import 'package:flutter_getx_st/binding/initialize/location_controller.dart';
import 'package:flutter_getx_st/config/config.dart';
import 'package:flutter_getx_st/http/com_dispatch_center.dart';
import 'package:flutter_getx_st/model/base_config.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_st/controller/initialization/initializtion_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 初始化注入
class Initializtion {
  static init() async {
    /// 注入 SharedPreferences
    await Get.putAsync<SharedPreferences>(
      () => SharedPreferences.getInstance(),
    );

    /// 本地配置
    await Get.putAsync<BaseConfig>(() => Config.getConfig());

    /// 网络请求配置
    Get.lazyPut(() => ComDispatchCenter.instance(Get.find<BaseConfig>()));

    /// 注入地址选择器
    await Get.putAsync<LocationController>(() async => LocationController());

    /// 初始化控制器
    Get.lazyPut(() => InitializtionController());
  }
}
