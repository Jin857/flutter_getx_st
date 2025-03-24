import 'package:flutter/material.dart';
import 'package:flutter_getx_st/binding/initialize/location_controller.dart';
import 'package:flutter_getx_st/config/color_config.dart';
import 'package:flutter_getx_st/page/component/seach/search_top.dart';
import 'package:flutter_getx_st/page/lobby/home/home_content_page.dart';
import 'package:flutter_getx_st/page/lobby/home/home_top_switch.dart';
import 'package:flutter_getx_st/page/popup/in_use_popup/home_channel_popup.dart';
import 'package:flutter_getx_st/page/popup/popup_page.dart';
import 'package:flutter_getx_st/plugins/refresh/my_smart_refresher.dart';
import 'package:get/get.dart';

class HomeFirstNew extends StatefulWidget {
  final int num;
  const HomeFirstNew({super.key, required this.num});
  @override
  State<HomeFirstNew> createState() => _HomeFirstNewState();
}

class _HomeFirstNewState extends State<HomeFirstNew>
    with SingleTickerProviderStateMixin {
  final locationController = Get.find<LocationController>();
  late int selectListIndex = 1;
  late PageController page;
  late List<String> list = [
    "关注",
    "推荐",
    "小时达",
    "换新",
    "国家补贴",
    "居家",
    "美食",
    "穿搭",
    "数码",
    "护肤",
    "户外",
  ];

  @override
  void initState() {
    super.initState();
    page = PageController(initialPage: selectListIndex);
    locationController.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.commonBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: SizedBox(
          width: double.infinity,
          height: 42,
          child: SearchTop(
            onTab: () {},
          ),
        ),
        bottom: HomeTopSwitch(
          list: list,
          onChange: (index) {
            setState(() {
              selectListIndex = index;
            });
            page.jumpToPage(selectListIndex);
          },
          onMore: () {
            PopupPage.topDialog(
              insetPadding: context.mediaQueryPadding,
              child: HomeChannelPopup(
                list: list,
                onChange: (index) {
                  setState(() {
                    selectListIndex = index;
                  });
                  page.jumpToPage(selectListIndex);
                },
              ),
            );
          },
          selectIndex: selectListIndex,
        ),
      ),
      body: PageView.builder(
        controller: page,
        onPageChanged: (value) {
          setState(() {
            selectListIndex = value;
          });
        },
        itemCount: list.length,
        itemBuilder: (context, pageIndex) {
          return MySmartRefresher(child: const HomeContentPage());
        },
      ),
    );
  }
}
