import 'package:flutter/material.dart';
import 'package:flutter_getx_st/page/lobby/home/home_first.dart';
import 'package:flutter_getx_st/page/lobby/home/home_first_new.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late ScrollController _scrollViewController;
  late PageController page;
  late TabController _tabController;
  final tabs = <String>['猜你喜欢', '今日特价', '发现更多'];
  final double outHeight = ScreenUtil().setSp(50);

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    page = PageController(initialPage: 0);
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // 构建 tabBar
    return NestedScrollView(
      controller: _scrollViewController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            leading: Container(),
            floating: true,
            expandedHeight: ScreenUtil().setSp(300) + outHeight,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                color: Colors.blue,
                height: double.infinity,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(""),
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(outHeight),
              child: Container(
                color: Colors.black12,
                width: double.maxFinite,
                child: TabBar(
                  tabs: tabs
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            e,
                            style: const TextStyle(height: 2, fontSize: 14),
                          ),
                        ),
                      )
                      .toList(),
                  onTap: (index) {
                    setState(() {});
                    page.jumpToPage(index);
                  },
                  controller: _tabController,
                  indicatorWeight: 2,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Colors.black,
                  isScrollable: true,
                  labelStyle: const TextStyle(fontSize: 16),
                  unselectedLabelColor:
                      const Color.fromRGBO(156, 166, 175, 1), //未选中的颜色
                ),
              ),
            ),
          )
        ];
      },
      body: PageView(
        controller: page,
        children: [
          HomeFirstPage(),
          HomeFirstNew(num: 200),
          HomeFirstNew(num: 20),
        ],
        onPageChanged: (index) {
          _tabController.animateTo(index);
          if (_scrollViewController.offset > (300 + outHeight)) {
            _scrollViewController.jumpTo(300 + outHeight);
          }
        },
      ),
    );
  }
}
