import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 上下刷新组建封装
// ignore: must_be_immutable
class MySmartRefresher extends StatefulWidget {
  Widget child;
  ScrollPhysics? physics;
  Function(RefreshController refresh)? onRefresh;
  Function(RefreshController refresh)? onLoading;

  MySmartRefresher({
    super.key,
    required this.child,
    this.onLoading,
    this.onRefresh,
    this.physics =
        const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
  });

  @override
  State<StatefulWidget> createState() => _MySmartRefresherState();
}

class _MySmartRefresherState extends State<MySmartRefresher> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  void _onRefresh(RefreshController refresh) async {
    await Future.delayed(const Duration(milliseconds: 5000));
    if (mounted) {
      setState(() {
        _refreshController.refreshCompleted();
      });
    }
  }

  void _onLoading(RefreshController refresh) async {
    await Future.delayed(const Duration(milliseconds: 5000));
    if (mounted) {
      setState(() {
        _refreshController.loadComplete();
      });
    }
  }

  Widget _onLoadingView(BuildContext context, LoadStatus? mode) {
    Widget body;
    if (mode == LoadStatus.idle) {
      body = const Text("上拉加载");
    } else if (mode == LoadStatus.loading) {
      body = const Text("加载中...");
    } else if (mode == LoadStatus.failed) {
      body = const Text("加载失败");
    } else if (mode == LoadStatus.canLoading) {
      body = const Text("松开加载更多");
    } else if (mode == LoadStatus.noMore) {
      body = const Text("没有更多数据");
    } else {
      body = const Text("");
    }
    return SizedBox(
      height: 30.0,
      child: Center(child: body),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      physics: widget.physics,
      enablePullDown: widget.onRefresh != null ? true : false,
      enablePullUp: widget.onLoading != null ? true : false,
      enableTwoLevel: false,
      header: const WaterDropHeader(
        complete: Text(" 数据加载成功 "),
        failed: Text(" 数据加载失败 "),
      ),
      footer: CustomFooter(
        builder: _onLoadingView,
      ),
      controller: _refreshController,
      onRefresh: () {
        widget.onRefresh == null
            ? _onRefresh(_refreshController)
            : widget.onRefresh?.call(_refreshController);
      },
      onLoading: () {
        widget.onLoading == null
            ? _onLoading(_refreshController)
            : widget.onLoading?.call(_refreshController);
      },
      child: widget.child,
    );
  }
}
