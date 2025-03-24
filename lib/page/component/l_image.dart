// 自动识别图片类型 是本地还是网络图片
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_getx_st/config/assets_config.dart';
import 'package:flutter_getx_st/plugins/shimmer/shimmer_loading.dart';

class LImage extends StatelessWidget {
  final String image;
  final String errorImage;
  final double? width;
  final double? height;
  final double? scale;
  final BoxFit? fit;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final Alignment alignment;
  final Color? color;

  const LImage({
    super.key,
    required String image,
    this.width,
    this.height,
    this.scale,
    this.fit,
    this.color,
    Alignment? alignment,
    String? errorImage,
    this.memCacheWidth,
    this.memCacheHeight,
  })  : alignment = alignment ?? Alignment.center,
        errorImage = errorImage ?? AssetsConfig.black,
        image = image == "" ? AssetsConfig.black : image;

  @override
  Widget build(BuildContext context) {
    // 用于计算图片类型
    bool ishttp = image.startsWith("http:") || image.startsWith("https:");
    Widget imageWidget;

    try {
      imageWidget = ishttp
          ? CachedNetworkImage(
              imageUrl: image,
              color: color,
              memCacheWidth: memCacheWidth,
              memCacheHeight: memCacheHeight,
              width: width,
              height: height,
              scale: scale ?? 1.0,
              alignment: alignment,
              fit: fit,
              placeholder: (context, url) => ShimmerLoading.rectangular(
                width: width,
                height: height,
              ),
              errorWidget: (context, url, error) => Image.asset(
                errorImage,
                color: color,
                width: width,
                height: height,
                scale: scale,
                fit: fit,
                alignment: alignment,
              ),
            )
          : Image.asset(
              image,
              color: color,
              width: width,
              height: height,
              scale: scale,
              fit: fit,
              alignment: alignment,
              errorBuilder: (build, object, stackTrace) {
                return Image.asset(
                  errorImage,
                  color: color,
                  width: width,
                  height: height,
                  scale: scale,
                  fit: fit,
                  alignment: alignment,
                );
              },
            );
    } on Exception catch (e) {
      debugPrint("image load error $e");
      imageWidget = Image.asset(
        errorImage,
        color: color,
        width: width,
        height: height,
        scale: scale,
        fit: fit,
        alignment: alignment,
      );
    }

    return imageWidget;
  }
}
