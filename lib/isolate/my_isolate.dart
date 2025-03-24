import 'dart:isolate';

class PointReq {
  SendPort send;

  Future<dynamic> Function() fetchData;

  PointReq({
    required this.send,
    required this.fetchData,
  });
}

/// 隔离需要兼容H5 - 但是isolate并不肩痛H5,而使用Web Worker代码复杂程度很高现简单处理
class MyIsolate {
  /// 开始使用 Isolate
  static startIsolate({
    required Future Function() fetchData,
    required Function callBack,
  }) async {
    print("--------1");
    ReceivePort receivePort = ReceivePort(); // 创建接收端口用于接收数据或消息。
    print("--------2");
    await Isolate.spawn(
      entryPoint,
      PointReq(
        send: receivePort.sendPort,
        fetchData: fetchData,
      ),
    ); // 启动Isolate并传递发送端口。
    receivePort.listen((data) {
      callBack(data);
      receivePort.close(); // 关闭接收端口。
    });
  }

  /// 开始使用进入异步处理
  static Future entryPoint(PointReq pointReq) async {
    print("--------3");
    pointReq.send.send(await pointReq.fetchData());
  }
}
