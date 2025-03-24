import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter_getx_st/isolate/my_isolate.dart';

Future<String> fetchData() async {
  // 模拟网络请求
  await Future.delayed(const Duration(microseconds: 200));
  return "模拟网络请求返回";
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => StateMyApp();
}

class StateMyApp extends State<MyApp> {
  late String text = "none";
  @override
  void initState() {
    super.initState();
    print("1:${DateTime.now()}");
    MyIsolate.startIsolate(
        fetchData: fetchData,
        callBack: (data) {
          print("------->$data");
          setState(() {
            text = " what i need: $data";
          });
          print("3:${DateTime.now()}");
        });
    print("2:${DateTime.now()}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Isolate Example')),
        body: Center(
          child: Text(" isolate: $text"),
        ),
      ),
    );
  }

  Future<String> _startIsolate() async {
    ReceivePort receivePort = ReceivePort(); // 创建接收端口用于接收数据或消息。
    await Isolate.spawn(entryPoint, receivePort.sendPort); // 启动Isolate并传递发送端口。
    String data = await receivePort.first; // 等待接收数据。
    receivePort.close(); // 关闭接收端口。
    return data; // 返回数据。
  }

  entryPoint(SendPort send) async {
    send.send(await fetchData());
  }
}
