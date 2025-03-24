import 'package:dio/dio.dart';
import 'package:flutter_getx_st/http/com_dispatch_center.dart';
import 'package:flutter_getx_st/model/user_model.dart';
import 'package:flutter_getx_st/utils/toast_util.dart';
import 'package:get/get.dart';

import '../../http/base/http_exception.dart';

class InitializtionController extends SuperController<UserInfo> {
  RxBool haseLogin = false.obs;
  @override
  void onInit() {
    super.onInit();
    updateUserInfo();
  }

  Future<UserInfo> getUserInfo() async {
    try {
      var value = await Get.find<ComDispatchCenter>().auth.getUserInfo();
      haseLogin.value = true;
      return value;
    } on DioException catch (e) {
      final NetError netError = HttpException.handleException(e);
      ToastUtils.show(netError.msg);
      haseLogin.value = false;
      throw Exception(e);
    }
  }

  // 更新用户信息
  void updateUserInfo() async {
    append(() => getUserInfo);
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
