import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';

// 多线程(isolate(隔离))验证以及用法
void main() {
  // test1();
  // test2();
  // test3();
  // test4();
  // test5();
  test6();
}

void func(int count) {
  print('1、搞定了！ $count');
}

void func2(int count) {
  print('2、搞定了！ $count');
}

//-------------------------多线程1---------------------
// 验证线程使用情况
void test1() {
  print('外部代码1');
  Isolate.spawn(func, 10);
  sleep(Duration(seconds: 1));
  print('外部代码2');
}

//-------------------------多线程2---------------------
// 打印出的日志是乱的 验证多线程互补干扰
void test2() {
  print('外部代码1');

  Isolate.spawn(func, 1);
  Isolate.spawn(func2, 2);
  Isolate.spawn(func, 3);
  Isolate.spawn(func2, 4);
  Isolate.spawn(func, 5);
  Isolate.spawn(func2, 6);
  Isolate.spawn(func, 7);
  Isolate.spawn(func2, 8);
  Isolate.spawn(func, 9);
  Isolate.spawn(func2, 10);

  sleep(Duration(seconds: 1));
  print('外部代码2');
}

//-------------------------多线程3---------------------
// 用来验证启动的Isolate是一个新单元，其内部改变并不能改变主Isolate中的内容
int a = 10;
void test3() {
  print('外部代码1');
  Isolate.spawn(func3, 100);
  sleep(Duration(seconds: 1));
  print('休眠回来之后的a是$a');
  print('外部代码2');
}

void func3(int count) {
  print('修改前a是$a');
  a = count;
  print('3、搞定了！');
  print('a现在是$a');
}

//-------------------------多线程4---------------------
// 多线程通讯
// 实现多线程之间的通讯通过ReceivePort进行监听
void test4() {
  print('外部代码1');

  // 创建Port 端口
  ReceivePort port = ReceivePort();
  Isolate.spawn(func4, port.sendPort);
  port.listen((message) {
    a = message;
    print('端口回来的数据a是$a');
  });

  // 目的是为了等待线程结束,因为这个线程比较慢
  sleep(Duration(seconds: 1));
  print('休眠回来之后的a是$a');
  print('外部代码2');
}

void func4(SendPort send) {
  print('4、搞定了！');
  send.send(1000);
}

//-------------------------多线程5---------------------
// 多线程 异步
// 实现多线程之间的通讯通过ReceivePort进行监听同时当监听事件结束后杀死线程
void test5() async {
  print('外部代码1');

  //  创建Port 端口
  ReceivePort port = ReceivePort();
  //  创建Isolate
  Isolate iso = await Isolate.spawn(func5, port.sendPort);

  port.listen((message) {
    a = message;
    print('端口回来的数据a是$a');
    iso.kill(); //使用完毕之后释放
  });

  sleep(Duration(seconds: 1));
  print('休眠回来之后的a是$a');
  print('外部代码2');
}

void func5(SendPort send) {
  print('5、搞定了！');
  send.send(1000); //给主线程发送消息（数据）
}

//-------------------------多线程6---------------------
// 多线程 compute 对 Isolate进行封装
void test6() async {
  print('外部代码1');

  // int x = await compute(func6, 10);
  // print(x);
  // 或者
  compute(func6, 10).then((value) => print(value));
  compute(func6, 21).then((value) => print(value));
  compute(func6, 22).then((value) => print(value));
  compute(func6, 32).then((value) => print(value));
  compute(func6, 33).then((value) => print(value));
  compute(func6, 34).then((value) => print(value));

  sleep(Duration(seconds: 1));
  print('外部代码2');
}

int func6(int count) {
  print("func6 count:$count");
  return 2000;
}
