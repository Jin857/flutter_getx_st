import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_getx_st/page/component/carousel/carousel_banner.dart';
import 'package:flutter_getx_st/page/component/l_image.dart';
import 'package:flutter_getx_st/page/component/product_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final images = const [
    "http://gips3.baidu.com/it/u=3557221034,1819987898&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=960",
    "https://img1.baidu.com/it/u=3447440298,1362600045&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500",
    "http://gips2.baidu.com/it/u=2161708353,627709820&fm=3028&app=3028&f=JPEG&fmt=auto?w=2560&h=1920",
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
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: SizedBox(
            height: 250,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned.fill(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                    child: LImage(image: images[_imageIndex], fit: BoxFit.fill),
                  ),
                ),
                SizedBox(
                  height: double.infinity,
                  child: CarouselBanner(
                    onPageChanged: (index) {
                      imageIndex = index;
                    },
                    images: images,
                  ),
                )
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final isOdd = index % 2 == 1;
                return Container(
                  alignment: Alignment.center,
                  color: isOdd ? Colors.black87 : Colors.black38,
                  child: GestureDetector(
                    onTap: () {},
                    child: LImage(
                      image: images[index],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
              childCount: images.length,
            ),
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 4,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              repeatPattern: QuiltedGridRepeatPattern.same,
              pattern: [
                const QuiltedGridTile(2, 2),
                const QuiltedGridTile(1, 1),
                const QuiltedGridTile(1, 1),
                const QuiltedGridTile(1, 2),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          sliver: SliverMasonryGrid(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final isOdd = index % 2 == 1;
                final imageIdex = index % 4;
                return Container(
                  alignment: Alignment.center,
                  color: isOdd ? Colors.white : const Color(0xFFEAEAEA),
                  child: GestureDetector(
                    onTap: () {},
                    child: ProductCard(
                      image: images[imageIdex],
                      name: "卡片内容($index)-$imageIdex",
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
