// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_getx_st/plugins/shimmer/shimmer_loading.dart';
import 'package:shimmer/shimmer.dart';

/// @description : 通用商品Item 微光加载布局
/// [width] 微光布局宽度
Widget productCardShimmer({double? width}) {
  return ShimmerLoading.rectangular(
    width: width ?? double.infinity,
    height: width ?? double.infinity,
  );
}

/// @description : 通用微光组件
/// [widget] 内嵌组件
/// [enabled] 控制微光效果是否处于活动状态
Widget commonShimmer({required Widget widget, bool enabled = true}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    enabled: enabled,
    child: widget,
  );
}

/// @description : 图片微光组件
/// [enabled] 控制微光效果是否处于活动状态
/// [width] 宽度/直径
/// [isCircular] 圆形/正方形
Widget imageShimmer({
  bool enabled = true,
  double width = 60,
  bool isCircular = true,
}) {
  return commonShimmer(
    enabled: enabled,
    widget: isCircular
        ? ClipRRect(
            borderRadius: BorderRadius.circular(width / 2),
            child: SizedBox(width: width, height: width),
          )
        : SizedBox(width: width, height: width),
  );
}

/// @description : 图片微光组件
/// [enabled] 控制微光效果是否处于活动状态
/// [fontSize] 字体大小
Widget textShimmer({
  bool enabled = true,
  double fontSize = 20,
}) {
  return commonShimmer(
    enabled: enabled,
    widget: SizedBox(
      width: 30,
      height: fontSize,
    ),
  );
}

/// @description : 图像字体Item
/// [enabled] 控制微光效果是否处于活动状态
/// [width] 宽度/直径
/// [isCircular] 圆形/正方形
Widget imageTextItemShimmer({
  bool enabled = true,
  double fontSize = 20,
  double width = 60,
  bool isCircular = true,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      imageShimmer(enabled: enabled, width: width, isCircular: isCircular),
      commonShimmer(
        enabled: enabled,
        widget: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 120.0, height: fontSize, color: Colors.white),
              const SizedBox(height: 16.0),
              Container(width: 120.0, height: fontSize, color: Colors.white),
            ],
          ),
        ),
      ),
    ],
  );
}
