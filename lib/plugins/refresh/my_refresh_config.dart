import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 本地刷新全局配置统一刷新样式
// ignore: must_be_immutable
class MyRefreshConfig extends StatelessWidget {
  Widget child;

  MyRefreshConfig({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      // 头部触发刷新的越界距离
      headerTriggerDistance: 80,
      footerTriggerDistance: 15.0,
      // 触发器twoLevel的超滚动距离
      twiceTriggerDistance: 150.0,
      // 关闭二层的底部穿越距离，前提:enableScrollWhenTwoLevel为true
      // 自定义回弹动画,三个属性值意义请查询flutter api
      closeTwoLevelDistance: 80.0,
      springDescription: const SpringDescription(
        stiffness: 150.0,
        damping: 16,
        mass: 2.2,
      ),
      //  头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
      maxOverScrollExtent: 100,
      // 底部最大可以拖动的范围
      maxUnderScrollExtent: 100,
      // 阻力速度比
      dragSpeedRatio: 0.91,
      // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
      headerBuilder: () => const MaterialClassicHeader(),
      // 配置默认底部指示器
      footerBuilder: () => const ClassicFooter(),
      // 在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
      enableLoadingWhenFailed: true,
      // Viewport不满一屏时,禁用上拉加载更多功能
      hideFooterWhenNotFull: false,
      // 可以通过惯性滑动触发加载更多
      enableBallisticLoad: true,
      enableLoadingWhenNoData: false,
      enableRefreshVibrate: false,
      enableLoadMoreVibrate: false,
      shouldFooterFollowWhenNotFull: (state) {
        //如果你想在noMoreData状态下加载更多，可能是你应该返回false
        return false;
      },
      child: child,
    );
  }
}
