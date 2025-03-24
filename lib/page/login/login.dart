import 'package:flutter/material.dart';
import 'package:flutter_getx_st/controller/login/login_controller.dart';
import 'package:flutter_getx_st/page/component/l_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  final LoginController controller;

  Login({super.key}) : controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.lightBlue[100],
          height: Get.height,
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.transparent,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LImage(
                        image:
                            "https://doc.flutterchina.club/images/flutter-mark-square-100.png",
                        width: ScreenUtil().setHeight(60),
                      ),
                      Align(
                        alignment: const Alignment(0, 2),
                        child: Text(
                          "带给您不一样的体验",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            height: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(100),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ScreenUtil().setSp(20)),
                      topRight: Radius.circular(ScreenUtil().setSp(20)),
                    ),
                  ),
                  height: 30.0,
                  child: const LoginRoute(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool pwdShow = false;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            TextFormField(
                controller: _unameController,
                decoration: const InputDecoration(
                  labelText: "手机号",
                  hintText: "手机号",
                  prefixIcon: Icon(Icons.phone_android_rounded),
                ),
                // 校验手机号（不能为空）
                validator: (v) {
                  return v == null || v.trim().isNotEmpty ? null : "请输入手机号";
                }),
            TextFormField(
              controller: _pwdController,
              decoration: InputDecoration(
                  labelText: "账户密码",
                  hintText: "账户密码",
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  suffixIcon: IconButton(
                    icon:
                        Icon(pwdShow ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        pwdShow = !pwdShow;
                      });
                    },
                  )),
              obscureText: !pwdShow,
              //校验密码（不能为空）
              validator: (v) {
                return v == null || v.trim().isNotEmpty ? null : "请输入密码";
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(25)),
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(
                  height: ScreenUtil().setHeight(40),
                ),
                child: ElevatedButton(
                  onPressed: _onLogin,
                  child: Text(
                    "登 陆",
                    style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLogin() async {
    // 先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      try {
        print("${_unameController.text},${_pwdController.text}");
      } finally {
        // 隐藏loading框
        Navigator.of(context).pop();
      }
    }
  }
}
