import 'package:flutter/material.dart';
import 'package:flutter_getx_st/config/color_config.dart';
import 'package:flutter_getx_st/page/lobby/find/find_content_page.dart';

class FindPage extends StatefulWidget {
  const FindPage({super.key});
  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage>
    with SingleTickerProviderStateMixin {
  int selectIndex = 0;
  List tabValues = ["科技", "军事", "历史"];
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabValues.length, vsync: this);
  }

  @override
  void didUpdateWidget(covariant FindPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.commonBackgroundColor,
      appBar: AppBar(
        //导航栏
        title: const Text("Scaffold页面"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              print("啦啦啦");
            },
          ),
        ],
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ));
          },
        ),
      ),
      body: const FindContentPage(),
    );
  }
}
