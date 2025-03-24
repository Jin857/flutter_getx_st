import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_getx_st/http/base/http_exception.dart';
import 'package:flutter_getx_st/http/base/http_model.dart';
import 'package:flutter_getx_st/model/base_config.dart';
import 'package:flutter_getx_st/utils/preferences/store.dart';
import 'package:flutter_getx_st/utils/toast_util.dart';

class NetClient {
  final BaseConfig baseConfig;

  NetClient({required this.baseConfig});

  late NetDio netDio = NetDio(baseConfig);

  /// 发起GET请求
  /// [url] 请求url
  /// [parameters] 请求参数
  Future get<T>(
    String url, {
    Object parameters = const {},
    bool isJson = false,
    URLType type = URLType.BASE,
  }) async {
    debugPrint("${Method.GET}:$url");
    var response = await netDio.request(
      Method.GET,
      url,
      parameters,
      isJson: isJson,
      type: type,
    );
    return response;
  }

  /// 发起GET请求
  /// [url] 请求url
  /// [params] 请求参数
  Future put<T>(
    String url, {
    Object? params,
    bool isJson = true,
    URLType type = URLType.BASE,
  }) async {
    debugPrint("${Method.PUT}:$url:$params");
    var response = await netDio.request(
      Method.PUT,
      url,
      params,
      isJson: isJson,
      type: type,
    );
    return response;
  }

  /// 发起POST请求
  /// [url] 请求url
  /// [params] 请求参数
  Future post<T>(
    String url, {
    Object? params,
    bool isJson = true,
    URLType type = URLType.BASE,
    bool isTokenOut = false,
  }) async {
    debugPrint("${Method.POST}:$url:$params");
    var response = await netDio.request(
      Method.POST,
      url,
      params,
      isJson: isJson,
      type: type,
      isTokenOut: isTokenOut,
    );
    return response;
  }
}

// 创建链接池
class NetDio {
  final BaseConfig baseConfig;
  late Dio dio;

  /// 连接超时时间
  final Duration _connectTimeout = const Duration(seconds: 10000);

  /// 接收超时时间
  final Duration _receiveTimeout = const Duration(seconds: 10000);

  /// 发送超时时间
  final Duration _sendTimeout = const Duration(seconds: 10000);

  NetDio(this.baseConfig) {
    // 初始化 dio
    var options = BaseOptions(
      validateStatus: (status) {
        return true;
      },
      baseUrl: baseConfig.baseUrl,
      sendTimeout: _sendTimeout,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
    );
    dio = Dio(options);
  }

  /// 更改dio为发送时需要的样子
  Dio sendDio([
    bool isJson = true,
    URLType type = URLType.BASE,
  ]) {
    String baseurl = baseConfig.baseUrl;
    switch (type) {
      case URLType.BASE:
        baseurl = baseConfig.baseUrl;
        break;
      case URLType.IMAGE:
        baseurl = baseConfig.imageUrl;
        break;
    }
    dio.options.baseUrl = baseurl;
    dio.options.contentType =
        isJson ? Headers.jsonContentType : Headers.formUrlEncodedContentType;
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = Store.getStringByAction(StoreAction.token) ?? "";
        if (token != "") {
          options.headers.addAll({'Authorization': "Bearer $token"});
        }
        return handler.next(options);
      },
    ));
    return dio;
  }

  /// 请求，返回参数为 T
  /// [method]：请求方法，Method.POST等
  /// [path]：请求地址
  /// [params]：请求参数
  Future request<T>(
    Method method,
    String path,
    dynamic params, {
    required URLType type,
    bool isJson = true,
    bool isTokenOut = false,
  }) async {
    try {
      Dio dio = sendDio(isJson, type);
      Response response = await dio.request(
        path,
        data: params,
        options: Options(
          method: methodValues[method],
        ),
      );
      return parse(response, isTokenOut);
    } on DioException catch (e) {
      final NetError netError = HttpException.handleException(e);
      onError(netError.code, netError.msg);
      ToastUtils.show(netError.msg);
      debugPrint("异常=====>${netError.msg}");
      return netError;
    }
  }

  RestReponse parse(Response response, bool isTokenOut) {
    debugPrint('${response.realUri}: ${response.data}');
    if (response.statusCode != 200) {
      ToastUtils.show("${response.statusCode} ");
      throw Exception('HTTP Error ${response.statusCode}');
    }
    var restReponse = RestReponse.fromJson(response.data);
    if (restReponse.code == 401) {
      ToastUtils.show("尚未登陆，请重新登陆");
    }
    if (restReponse.code != 0 && !isTokenOut) {
      if (restReponse.msg != "") {
        ToastUtils.show("${restReponse.msg} ");
        throw RestReponseException(
          message: "${restReponse.msg}",
          restReponse: restReponse,
        );
      } else if (restReponse.message != "") {
        ToastUtils.show("${restReponse.message} ");
        throw RestReponseException(
          message: "${restReponse.message}",
          restReponse: restReponse,
        );
      }
    }
    return restReponse;
  }
}
