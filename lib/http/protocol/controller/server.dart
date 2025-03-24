import 'package:flutter_getx_st/http/api/config.dart';
import 'package:flutter_getx_st/http/base/http_model.dart';
import 'package:flutter_getx_st/http/base/net_client.dart';
import 'package:flutter_getx_st/http/com_dispatch_center.dart';
import 'package:flutter_getx_st/http/protocol/base/common_protocol.dart';
import 'package:flutter_getx_st/http/protocol/base/default_protocol.dart';
import 'package:flutter_getx_st/model/base_config.dart';
import 'package:flutter_getx_st/model/user_model.dart';

class ServerComDispatchCenter extends ComDispatchCenter {
  final _ServerComDispatchCenter _protocol;

  @override
  AuthProtocol get auth => _protocol;

  @override
  LobbyProtocol get lobby => _protocol;

  ServerComDispatchCenter(
    BaseConfig config,
  ) : _protocol = _ServerComDispatchCenter(config);
}

class _ServerComDispatchCenter extends DefaultProtocol {
  final NetClient netClient;

  _ServerComDispatchCenter(
    BaseConfig config,
  ) : netClient = NetClient(baseConfig: config);

  @override
  Future<LoginRes> login(LoginInfo loginInfo) async {
    RestReponse response = await netClient.post(
      ConfigApi.login,
      params: loginInfo.toJson(),
    );
    return LoginRes.fromJson(response.data);
  }

  @override
  Future<UserInfo> getUserInfo() async {
    RestReponse response = await netClient.get(ConfigApi.userInfo);
    return UserInfo.fromJson(response.data);
  }
}
