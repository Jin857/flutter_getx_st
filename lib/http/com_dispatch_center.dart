import 'package:flutter_getx_st/http/protocol/base/common_protocol.dart';
import 'package:flutter_getx_st/http/protocol/controller/location.dart';
import 'package:flutter_getx_st/http/protocol/controller/server.dart';
import 'package:flutter_getx_st/model/base_config.dart';

/// 请求调度中心
abstract class ComDispatchCenter {
  static ComDispatchCenter? _instance;
  static ComDispatchCenter instance(BaseConfig config) {
    if (_instance == null) {
      switch (config.mode) {
        case DevelopMode.DEBUG:
        case DevelopMode.RELEASE:
          _instance = ServerComDispatchCenter(config);
          break;
        case DevelopMode.LOCAL:
          _instance = LocationComDispatchCenter(config);
          break;

        default:
          _instance = ServerComDispatchCenter(config);
      }
    }
    return _instance!;
  }

  /// 大厅API
  LobbyProtocol get lobby;

  /// 用户认证API
  AuthProtocol get auth;

  static ComDispatchCenter simulator = _instance!;
}
