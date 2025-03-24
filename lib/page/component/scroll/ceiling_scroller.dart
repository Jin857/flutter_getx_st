import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx_st/config/assets_config.dart';
import 'package:flutter_getx_st/page/component/l_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CeilingScroller extends StatefulWidget {
  const CeilingScroller({super.key});
  @override
  State<CeilingScroller> createState() => _CeilingScrollerState();
}

class _CeilingScrollerState extends State<CeilingScroller>
    with SingleTickerProviderStateMixin {
  ScrollController scrollCon1 = ScrollController(keepScrollOffset: false);
  ScrollController scrollCon2 = ScrollController();
  GlobalKey bottomScrollerKey = GlobalKey(debugLabel: 'bottomScroller');

  @override
  void initState() {
    super.initState();
    scrollCon1.addListener(_scrollerChange);
  }

  void _scrollerChange() {
    /// 滚动中
    final keyRenderObject =
        bottomScrollerKey.currentContext?.findAncestorRenderObjectOfType();
    if (keyRenderObject != null) {
      final offsetY = (keyRenderObject.parentData as SliverPhysicalParentData)
          .paintOffset
          .dy;
      print(
          "----> ${offsetY <= 0} , ${offsetY}, ${MediaQuery.of(context).padding.top + ScreenUtil().setHeight(60)} ");
    }
  }

  @override
  void didUpdateWidget(covariant CeilingScroller oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollCon1,
        slivers: <Widget>[
          /// 顶部栏，固定在顶部
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverCustomAppHeader(
              title: '哪吒之魔童降世',
              collapsedHeight: ScreenUtil().setHeight(60),
              expandedHeight: (432 * Get.width) / 810,
              shrinkHeight: ScreenUtil().setHeight(60),
              bottomHeight: ScreenUtil().setHeight(40),
              paddingTop: MediaQuery.of(context).padding.top,
              coverImgUrl: AssetsConfig.commotop,
            ),
          ),

          /// 比如 Banner，金刚区等
          const SliverToBoxAdapter(
            child: TopBar(),
          ),

          /// 吸顶的标签栏
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverCustomHeaderDelegate(
              title: '哪吒之魔童降世',
              collapsedHeight: 60,
              expandedHeight: 60,
              shrinkHeight: 60,
              paddingTop: 0,
            ),
          ),
          SliverFillRemaining(
            child: PageView(
              key: bottomScrollerKey,
              children: <Widget>[
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: scrollCon2,
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Item $index'),
                    );
                  },
                ),
                Container(color: Colors.green),
                Container(color: Colors.blue),
              ],
            ),
          ),

          /// 列表
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index) {
          //       return ListTile(
          //         title: Text('Item $index'),
          //       );
          //     },
          //     childCount: 20,
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: PageView.custom(
          //     childrenDelegate: SliverChildBuilderDelegate(
          //       (context, index) {
          //         return ListTile(
          //           title: Text('Item $index'),
          //         );
          //       },
          //       childCount: 20,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

/// 顶部查询搜索
class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(Object context) {
    return Container(
      color: Colors.red,
      width: double.infinity,
      height: 200,
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SliverCustomAppHeader extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double shrinkHeight;
  final double paddingTop;
  final double bottomHeight;
  final String coverImgUrl;
  final String title;

  String statusBarMode = 'dark';

  SliverCustomAppHeader({
    required this.collapsedHeight,
    required this.expandedHeight,
    required this.shrinkHeight,
    required this.paddingTop,
    required this.title,
    required this.coverImgUrl,
    required this.bottomHeight,
  });

  @override
  double get minExtent => collapsedHeight + paddingTop;

  @override
  double get maxExtent => expandedHeight + bottomHeight;

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
      return isIcon ? Colors.white : Colors.transparent;
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
            child: LImage(image: coverImgUrl, fit: BoxFit.fitWidth),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: SizedBox(
                  height: collapsedHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: shrinkHeight + paddingTop,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setSp(10)),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setSp(10),
                ),
              ),
              height: (expandedHeight - shrinkHeight) - ScreenUtil().setSp(5),
            ),
          ),
        ],
      ),
    );
  }
}
