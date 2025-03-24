import 'package:flutter_getx_st/http/com_dispatch_center.dart';
import 'package:flutter_getx_st/http/protocol/base/common_protocol.dart';
import 'package:flutter_getx_st/http/protocol/base/default_protocol.dart';
import 'package:flutter_getx_st/model/base_config.dart';

class LocationComDispatchCenter extends ComDispatchCenter {
  final _LocationComDispatchCenter _protocol;

  @override
  AuthProtocol get auth => _protocol;

  @override
  LobbyProtocol get lobby => _protocol;

  LocationComDispatchCenter(
    BaseConfig config,
  ) : _protocol = _LocationComDispatchCenter();
}

class _LocationComDispatchCenter extends DefaultProtocol {}
