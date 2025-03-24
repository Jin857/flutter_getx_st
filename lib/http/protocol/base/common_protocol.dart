import 'package:flutter_getx_st/model/user_model.dart';

/// 认证
abstract class AuthProtocol {
  /// 登陆
  Future<LoginRes> login(LoginInfo loginInfo);

  /// 个人信息
  Future<UserInfo> getUserInfo();
}

/// 大厅
abstract class LobbyProtocol {}
