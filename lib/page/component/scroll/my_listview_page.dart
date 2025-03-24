import 'package:flutter/material.dart';
import 'package:flutter_getx_st/plugins/refresh/my_smart_refresher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 请求加载滚动界面
/// ListView 再次封装
class MyScrollList<T> extends StatefulWidget {
  final int pageSize;

  /// 列表样式
  final Widget? Function(BuildContext context, dynamic data) mItemBuilder;

  /// 获取页数据
  final Future<List<T>> Function(int pageSize, int pageNum) getPageData;

  /// 暂无数据样式
  final Widget? noDataWidget;

  /// 初始加载样式
  final Widget? loaddingWidget;

  const MyScrollList({
    super.key,
    required this.mItemBuilder,
    required this.getPageData,
    int? pageSize,
    this.noDataWidget,
    this.loaddingWidget,
  }) : pageSize = pageSize ?? 15;

  @override
  State<StatefulWidget> createState() => _ScrollListState<T>();
}

class _ScrollListState<T> extends State<MyScrollList> {
  /// 当前页面
  int currentNum = 0;

  /// 加载中的页面
  int pageNum = 0;

  /// 是否加载中
  bool isLoadding = false;

  /// 是否已加载全部
  bool isAddAll = false;

  /// 是否加载失败
  bool isloadError = false;

  /// 列表数据集合
  List<dynamic> page = [];

  /// 加载数据
  @override
  void initState() {
    super.initState();
    isLoadding = true;

    /// 加载数据
    pageNum = 1;
    getPageList();
  }

  /// 获取下一页数据
  getPageList() async {
    isloadError = false;
    try {
      var list = await widget.getPageData(widget.pageSize, pageNum);
      isLoadding = false;
      if (list.isNotEmpty) {
        setState(() {
          currentNum = pageNum;
          if (pageNum == 1) {
            page = list;
          } else {
            page.addAll(list);
          }
        });
      } else {
        /// 已加载全部
        isAddAll = true;
      }
    } catch (e) {
      isloadError = true;
      isLoadding = false;
      debugPrint("get page list error");
    }
  }

  @override
  void dispose() {
    page.clear();
    super.dispose();
  }

  onLoading(RefreshController refresh) async {
    pageNum = currentNum + 1;
    await getPageList();
    if (isloadError) {
      refresh.loadFailed();
    } else {
      if (isAddAll) {
        refresh.loadNoData();
      } else {
        refresh.loadComplete();
      }
    }
  }

  onRefresh(RefreshController refresh) async {
    isAddAll = false;
    pageNum = 1;
    await getPageList();
    if (isloadError) {
      refresh.refreshFailed();
    } else {
      refresh.loadComplete();
      refresh.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MySmartRefresher(
      onLoading: onLoading,
      onRefresh: onRefresh,
      child: isLoadding
          ? widget.loaddingWidget ??
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "数据加载中",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              )
          : page.isEmpty
              ? widget.noDataWidget ??
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "暂无数据",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  )
              : ListView.builder(
                  itemCount: page.length,
                  itemBuilder: (context, index) {
                    var item = page[index];
                    return widget.mItemBuilder(context, item);
                  },
                ),
    );
  }
}
