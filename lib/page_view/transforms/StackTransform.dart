import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../view_page.dart';

class StackTransform extends PageTransform {
  final double maxHeight;
  final double childHeight;
  final double topPaddingOffset;

  StackTransform({
    this.maxHeight = 400.0,
    this.childHeight = 200.0,
    this.topPaddingOffset = 170,
  });

  @override
  Widget transform(int index, double page, double aniValue, Widget child) {
    return vertical(aniValue, index, page, child);
  }

  Widget vertical(double aniValue, int index, double page, Widget child) {
    var opacity = 1.0;

    ///不用缩放的
    if (index >= page) {
      /// _pageController.page > index 向右滑动 划出下一页 下一页可见
      return child;
    } else {
      /// page:当前显示的页面，index：每个item的下标
      /// pageOffset 在0-2之间
      var pageOffset = page - index;

      /// pageOffset: 页面偏移 （0.0-1.0）

      var topPadding = pageOffset * topPaddingOffset;

      opacity = 1 - (pageOffset / 3);

      var scale = 1 - (pageOffset / 15);
      // if (scale < 0.5) {
      //   scale = 0.5;
      // }
      if (topPadding < 0) {
        topPadding = 0;
      }
      // if (topPadding > 500) {
      //   topPadding = 500;
      // }
      if (opacity < 0.3) {
        opacity = 0.3;
      }
      // if (pageOffset >= 2) {
      //   opacity = 0.0;
      // }
      if (opacity > 1) {
        opacity = 1;
      }

      ///index=0,page=0.998071930825017,aniValue=0.0019280691749830048，pageOffset=0.998071930825017,topPadding=179.65294754850305
      print(
          'index=$index,page=${page.toStringAsFixed(2)},scale=${scale.toStringAsFixed(2)}，'
          'pageOffset=${pageOffset.toStringAsFixed(2)},topPadding=${topPadding.toStringAsFixed(2)}'
          ',opacity=${opacity.toStringAsFixed(2)}');
      return OverflowBox(
        alignment: Alignment.topCenter,
        maxHeight: maxHeight,
        child: Container(
          height: childHeight,
          margin: EdgeInsets.only(top: topPadding),
          child: Opacity(
            opacity: opacity,
            child: Transform.scale(
                alignment: Alignment.topCenter, scale: scale, child: child),
          ),
        ),
      );
    }
  }
}
