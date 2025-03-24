import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_st/http/base/http_exception.dart';
import 'package:flutter_getx_st/http/base/http_model.dart';
import 'package:flutter_getx_st/utils/toast_util.dart';

class HttpGeneral {
  /// Get请求
  /// [url] 请求地址
  /// [isTokenOut] 是否检测等处
  static Future<RestReponse> generalGet({
    required String url,
    bool isTokenOut = false,
  }) async {
    try {
      var dio = Dio();
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      return parse(response, false);
    } on DioException catch (e) {
      final NetError netError = HttpException.handleException(e);
      onError(netError.code, netError.msg);
      ToastUtils.show(netError.msg);
      throw netError;
    }
  }

  static RestReponse parse(Response response, bool isTokenOut) {
    debugPrint(
        '${response.realUri}: ${response.statusCode} : ${response.data}');
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
    print("------------------");
    return restReponse;
  }
}
