import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_getx_st/page/component/carousel/carousel_banner.dart';
import 'package:flutter_getx_st/page/component/l_image.dart';
import 'package:flutter_getx_st/page/component/product_card.dart';
import 'package:flutter_getx_st/page/lobby/home/home_top_switch.dart';
import 'package:flutter_getx_st/page/popup/in_use_popup/home_channel_popup.dart';
import 'package:flutter_getx_st/page/popup/popup_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class FindContentPage extends StatefulWidget {
  const FindContentPage({super.key});

  @override
  State<FindContentPage> createState() => _FindContentPageState();
}

class _FindContentPageState extends State<FindContentPage>
    with SingleTickerProviderStateMixin {
  final images = const [
    "http://gips3.baidu.com/it/u=3557221034,1819987898&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=960"
        "https://img1.baidu.com/it/u=3447440298,1362600045&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500",
    "http://gips2.baidu.com/it/u=2161708353,627709820&fm=3028&app=3028&f=JPEG&fmt=auto?w=2560&h=1920",
    "http://gips2.baidu.com/it/u=3579059838,1031544773&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=720",
    "http://gips2.baidu.com/it/u=3579059838,1031544773&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=720",
    "http://gips2.baidu.com/it/u=3579059838,1031544773&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=720",
  ];
  late int _imageIndex = 0;
  set imageIndex(index) {
    setState(() {
      _imageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final isOdd = index % 2 == 1;
              return Container(
                alignment: Alignment.center,
                color: isOdd ? Colors.white : const Color(0xFFEAEAEA),
                child: Text(
                  index.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              );
            },
            childCount: 10,
          ),
          itemExtent: 30,
        ),
        SliverMasonryGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final isOdd = index % 2 == 1;
              return Container(
                alignment: Alignment.center,
                color: isOdd ? Colors.white : const Color(0xFFEAEAEA),
                child: GestureDetector(
                  onTap: () {},
                  child: ProductCard(
                    image: "",
                    name: "卡片内容($index)",
                    subtitle: index % 3 == 1
                        ? "卡拉斯京卢卡斯家了阿斯利。"
                        : index % 3 == 2
                            ? "卡拉斯京卢卡斯家了阿斯利康将阿斯科利阿斯科利将阿斯利康将，啊商家阿斯利康将阿三，失联客机啊算了。"
                            : "卡拉斯京卢卡斯家了阿斯利康将阿斯科利阿斯科利将阿斯利康将，啊商家阿斯利康将阿三，失联客机啊算了。卡拉斯京卢卡斯家了阿斯利康将阿斯科利阿斯科利将阿斯利康将，啊商家阿斯利康将阿三，失联客机啊算了。",
                  ),
                ),
              );
            },
            childCount: 30,
          ),
          gridDelegate: SliverSimpleGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: Get.width / 2,
          ),
        ),
      ],
    );
  }
}
