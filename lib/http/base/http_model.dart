/// 请求类型枚举
enum Method {
  GET,
  POST,
  DELETE,
  PUT,
  PATCH,
  HEAD,
}

/// Url 类型
enum URLType {
  /// 基础 URL
  BASE,

  /// 图片相关 URL
  IMAGE,
}

///请求类型值
const methodValues = {
  Method.GET: "get",
  Method.POST: "post",
  Method.DELETE: "delete",
  Method.PUT: "put",
  Method.PATCH: "patch",
  Method.HEAD: "head",
};

/// 成功
typedef Success<T> = Function(T data);

/// 失败
typedef Fail = Function(int code, String msg);

/// 返回数据
class RestReponse<T> {
  int code;
  T? data;
  String? msg;
  int? count;
  int? btype;

  String? message;
  String? type;
  T? result;

  RestReponse({
    required this.code,
    this.data,
    this.msg,
    this.count,
    this.btype,
    this.message,
    this.type,
    this.result,
  });

  factory RestReponse.fromJson(Map<String, dynamic> json) {
    return RestReponse(
      code: json['code'] ?? -1,
      msg: json['msg'] ?? "",
      data: json['data'],
      count: json['count'] ?? -1,
      btype: json['btype'] ?? -1,
      message: json['message'] ?? "",
      type: json['type'] ?? "",
      result: json['result'],
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'msg': msg,
        'data': data,
        'count': count,
        'btype': btype,
        'message': message,
        'type': type,
        'result': result,
      };
  bool get isSuccess => code == 0;
}

/// 返回数据异常抛出
class RestReponseException implements Exception {
  final dynamic message;
  final RestReponse? restReponse;

  RestReponseException({
    this.message,
    this.restReponse,
  });

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}
