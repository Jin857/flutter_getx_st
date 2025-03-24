import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// @desc:Flutter 微光动画效果
class ShimmerLoading extends StatelessWidget {
  final double? width;
  final double? height;
  final ShapeBorder shapeBorder;
  final Widget? child;

  /// 方形
  const ShimmerLoading.rectangular({
    super.key,
    this.width = double.infinity,
    this.height,
    this.child,
    this.shapeBorder = const RoundedRectangleBorder(),
  });

  /// 圆形
  const ShimmerLoading.circular({
    super.key,
    this.width = double.infinity,
    this.height,
    this.child,
    this.shapeBorder = const CircleBorder(),
  });

  const ShimmerLoading.child({
    super.key,
    this.width = double.infinity,
    this.height,
    this.child,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        period: const Duration(seconds: 2),
        child: child ??
            Container(
              width: width,
              height: height,
              decoration: ShapeDecoration(
                color: Colors.grey[400]!,
                shape: shapeBorder,
              ),
            ),
      );
}
