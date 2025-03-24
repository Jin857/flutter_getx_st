import 'package:flutter_getx_st/http/protocol/base/common_protocol.dart';
import 'package:flutter_getx_st/model/user_model.dart';

class DefaultProtocol implements AuthProtocol, LobbyProtocol {
  @override
  Future<LoginRes> login(LoginInfo loginInfo) {
    throw UnimplementedError();
  }

  @override
  Future<UserInfo> getUserInfo() {
    throw UnimplementedError();
  }
}
