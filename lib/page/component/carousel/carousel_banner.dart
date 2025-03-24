import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_st/page/component/l_image.dart';

class CarouselBanner extends StatelessWidget {
  final List<String> images;
  final Function(int index) onPageChanged;
  const CarouselBanner({
    super.key,
    required this.images,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            onPageChanged(index);
          }),
      items: images
          .map(
            (item) => Container(
              color: Colors.black12,
              margin: const EdgeInsets.all(5.0),
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: LImage(image: item, fit: BoxFit.fill),
              ),
            ),
          )
          .toList(),
    );
  }
}
