import 'package:flutter/material.dart';
import 'package:flutter_getx_st/config/assets_config.dart';
import 'package:flutter_getx_st/routes/app_pages.dart';
import 'package:get/get.dart';

class HeroAnimationRouteA extends StatelessWidget {
  const HeroAnimationRouteA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("原图"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            InkWell(
              child: Hero(
                tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
                child: ClipOval(
                  child: Image.asset(
                    AssetsConfig.commotop,
                    width: 50.0,
                  ),
                ),
              ),
              onTap: () {
                print("-------------");
                //打开B路由
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const HeroAnimationRouteB(),
                //   ),
                // );

                Get.rootDelegate.offAndToNamed("${Routes.LOBBY}/${Routes.HREOB}");

                // Navigator.push(context, PageRouteBuilder(
                //   pageBuilder:
                //       (BuildContext context, animation, secondaryAnimation) {
                //     return FadeTransition(
                //       opacity: animation,
                //       child: const HeroAnimationRouteB(),
                //     );
                //   },
                // ));
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text("点击头像"),
            )
          ],
        ),
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  const HeroAnimationRouteB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("原图"),
      ),
      body: Hero(
        tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
        child: Center(
            child: Column(
          children: [
            Image.asset(
              AssetsConfig.background,
              width: 100,
            ),
            Text("0000000011"),
          ],
        )),
      ),
    );
  }
}
