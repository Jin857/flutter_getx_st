import 'package:flutter/widgets.dart';
import 'package:flutter_getx_st/controller/initialization/initializtion_controller.dart';
import 'package:flutter_getx_st/http/com_dispatch_center.dart';
import 'package:flutter_getx_st/model/user_model.dart';
import 'package:flutter_getx_st/utils/preferences/store.dart';
import 'package:flutter_getx_st/utils/toast_util.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var initializtionController = Get.find<InitializtionController>();

  final loginInfo = LoginInfo.fromJson({});
  RxBool chickPaw = false.obs;
  RxBool checkPrivacy = false.obs;
  bool hasLogin = false;

  onChickPaw() {
    chickPaw.value = !chickPaw.value;
  }

  onCheckPrivacy(bool boo) {
    checkPrivacy.value = boo;
  }

  // 提交登陆
  submitLogin() async {
    if (hasLogin) {
      return;
    }
    if (loginInfo.mobile == "") {
      ToastUtils.show("请输入用户名");
    } else if (loginInfo.passWord == "") {
      ToastUtils.show("请输入密码");
    } else if (!checkPrivacy.value) {
      ToastUtils.show("请同意服务条款～");
    } else {
      hasLogin = true;
      try {
        var value = await Get.find<ComDispatchCenter>().auth.login(loginInfo);
        await Store.setStringByAction(StoreAction.token, value.token);
        initializtionController.updateUserInfo();
        Get.rootDelegate.offNamed("/lobby");
        hasLogin = false;
      } catch (e) {
        debugPrint("登陆异常：$e");
        hasLogin = false;
      }
    }
  }

  // 页面修改内容
  void onChangeByName(name, value) {
    switch (name) {
      case "password":
        loginInfo.passWord = value;
        break;
      case "mobile":
        loginInfo.mobile = value;
        break;
    }
  }
}
