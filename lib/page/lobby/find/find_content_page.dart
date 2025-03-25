import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_getx_st/page/component/product_card.dart';
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
    "http://gips3.baidu.com/it/u=3557221034,1819987898&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=960",
    "https://img1.baidu.com/it/u=3447440298,1362600045&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500",
    "http://gips2.baidu.com/it/u=2161708353,627709820&fm=3028&app=3028&f=JPEG&fmt=auto?w=2560&h=1920",
    "http://gips2.baidu.com/it/u=3579059838,1031544773&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=720",
  ];

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

        /// 吸顶的标签栏
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverCustomHeaderDelegate(
            title: '吸顶内容',
            collapsedHeight: 60,
            expandedHeight: 60,
            shrinkHeight: 60,
            paddingTop: 0,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          sliver: SliverMasonryGrid(
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final isOdd = index % 2 == 1;
                final imageIndex = index % 4;
                return Container(
                  alignment: Alignment.center,
                  color: isOdd ? Colors.white : const Color(0xFFEAEAEA),
                  child: GestureDetector(
                    onTap: () {},
                    child: ProductCard(
                      image: images[imageIndex],
                      name: "卡片内容",
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
        ),
      ],
    );
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double shrinkHeight;
  final double paddingTop;
  final String title;
  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({
    required this.collapsedHeight,
    required this.expandedHeight,
    required this.shrinkHeight,
    required this.paddingTop,
    required this.title,
  });

  @override
  double get minExtent => collapsedHeight + paddingTop;

  @override
  double get maxExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  void updateStatusBarBrightness(shrinkOffset) {
    if (shrinkOffset > shrinkHeight && statusBarMode == 'dark') {
      statusBarMode = 'light';
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    } else if (shrinkOffset <= shrinkHeight && statusBarMode == 'light') {
      statusBarMode = 'dark';
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    }
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= shrinkHeight) {
      return isIcon ? Colors.transparent : Colors.transparent;
    } else {
      final int alpha =
          (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    updateStatusBarBrightness(shrinkOffset);
    return SizedBox(
      height: maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                top: false,
                child: Container(
                  color: Colors.red[100],
                  height: collapsedHeight,
                  alignment: Alignment.centerLeft,
                  child: Text(title),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
