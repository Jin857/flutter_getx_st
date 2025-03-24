import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 存储数据到本地
enum StoreAction {
  /// token
  token,

  /// 第一次登陆通知
  firstNotification,
}

class Store {
  static Object? getByAction(StoreAction key) {
    return Get.find<SharedPreferences>().get(key.toString());
  }

  static String? getStringByAction(StoreAction key) {
    return Get.find<SharedPreferences>().getString(key.toString());
  }

  static bool? getBoolByAction(StoreAction key) {
    return Get.find<SharedPreferences>().getBool(key.toString());
  }

  static int? getIntByAction(StoreAction key) {
    return Get.find<SharedPreferences>().getInt(key.toString());
  }

  static List<String>? getStringListByAction(StoreAction key) {
    return Get.find<SharedPreferences>().getStringList(key.toString());
  }

  static Future<bool> setStringByAction(StoreAction key, String value) async {
    return Get.find<SharedPreferences>().setString(key.toString(), value);
  }

  static Future<bool> setIntByAction(StoreAction key, int value) async {
    return Get.find<SharedPreferences>().setInt(key.toString(), value);
  }

  static Future<bool> setBoolByAction(StoreAction key, bool value) async {
    return Get.find<SharedPreferences>().setBool(key.toString(), value);
  }

  static Future<bool> setStringListByAction(
    StoreAction key,
    List<String> list,
  ) async {
    return Get.find<SharedPreferences>().setStringList(key.toString(), list);
  }
}
