import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_st/movie_app/movie.dart';
import 'package:flutter_getx_st/config/color_config.dart';
import 'package:flutter_getx_st/page/component/todo.dart';
import 'package:flutter_getx_st/page/lobby/find/find_page.dart';
import 'package:flutter_getx_st/page/lobby/persion/persion.dart';
import 'package:flutter_getx_st/page/lobby/home/home_first_new.dart';
import 'package:flutter_getx_st/page/component/keep_alive_wrapper.dart';

class LobbyMain extends StatefulWidget {
  const LobbyMain({super.key});

  @override
  State<LobbyMain> createState() => _LobbyMainState();
}

class _LobbyMainState extends State<LobbyMain> {
  late PageController pageController;
  late int currentIndex;

  final pages = [
    const KeepAliveWrapper(
      child: HomeFirstNew(num: 20),
    ),
    const KeepAliveWrapper(
      child: FindPage(),
    ),
    const KeepAliveWrapper(
      child: MovieDisplay(),
    ),
    KeepAliveWrapper(
      child: Persion(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    pageController = PageController(initialPage: currentIndex);
  }

  /// 切换页面
  @Deprecated('use turnOn instead')
  void changePage(int index) {
    turnOn(index);
  }

  @Todo('turnOn', '页面切换')
  void turnOn(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: ColorConfig.commonBackgroundColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(40)),
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.linearToSrgbGamma(),
              image: NetworkImage(
                "https://images.pexels.com/photos/3902882/pexels-photo-3902882.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
              ),
            ),
          ),
          child: FloatingActionButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(35),
              ),
            ),
            backgroundColor: Colors.transparent,
            child: const Icon(
              Icons.snapchat_outlined,
              size: 36,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 70,
          color: Colors.white,
          shadowColor: Colors.amber,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BottomNavigationBarButton(
                index: 0,
                title: "首页",
                selectIcons: Icons.home_rounded,
                normalIcons: Icons.home_outlined,
                onClick: (index) {
                  turnOn(index);
                  pageController.jumpToPage(index);
                },
                select: currentIndex == 0,
              ),
              BottomNavigationBarButton(
                index: 1,
                title: "发现",
                selectIcons: Icons.explore_rounded,
                normalIcons: Icons.explore_outlined,
                onClick: (index) {
                  turnOn(index);
                  pageController.jumpToPage(index);
                },
                select: currentIndex == 1,
              ),
              BottomNavigationBarButton(
                index: 2,
                title: "休闲",
                selectIcons: Icons.coffee_rounded,
                normalIcons: Icons.coffee_outlined,
                onClick: (index) {
                  turnOn(index);
                  pageController.jumpToPage(index);
                },
                select: currentIndex == 2,
              ),
              BottomNavigationBarButton(
                index: 3,
                title: "我",
                selectIcons: Icons.person_4_rounded,
                normalIcons: Icons.person_4_outlined,
                onClick: (index) {
                  turnOn(index);
                  pageController.jumpToPage(index);
                },
                select: currentIndex == 3,
              ),
            ],
          ),
        ),
        body: PageView.builder(
          itemCount: pages.length,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: changePage,
          controller: pageController,
          itemBuilder: (context, index) {
            return pages[index];
          },
        ),
      ),
    );
  }
}

class BottomNavigationBarButton extends StatelessWidget {
  final Function(int index) onClick;
  final int index;
  final String title;
  final bool select;
  final Color selectColor;
  final Color normalColor;
  final IconData selectIcons;
  final IconData normalIcons;
  const BottomNavigationBarButton({
    super.key,
    required this.index,
    required this.onClick,
    required this.select,
    Color? selectColor,
    Color? normalColor,
    IconData? selectIcons,
    IconData? normalIcons,
    String? title,
  })  : selectColor = selectColor ?? Colors.red,
        normalColor = normalColor ?? Colors.black54,
        selectIcons = selectIcons ?? Icons.abc,
        normalIcons = normalIcons ?? Icons.abc_rounded,
        title = title ?? "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick(index);
      },
      child: Container(
        width: Get.width / 5,
        color: Colors.white.withOpacity(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              select ? selectIcons : normalIcons,
              color: select ? selectColor : normalColor,
            ),
            if (title.isNotEmpty)
              Text(
                title,
                style: TextStyle(
                  color: select ? selectColor : normalColor,
                  fontSize: 12,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
