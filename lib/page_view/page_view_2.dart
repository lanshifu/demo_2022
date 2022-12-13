import 'dart:ui';

import 'package:demo_2022/page_view/transforms/StackTransform.dart';
import 'package:demo_2022/page_view/view_page.dart';
import 'package:flutter/material.dart';

class PageView2 extends StatefulWidget {
  const PageView2({Key? key}) : super(key: key);

  @override
  State<PageView2> createState() => _PageView2State();
}

class _PageView2State extends State<PageView2> {
  @override
  Widget build(BuildContext context) {
    var topPadding = -400.0;

    ///屏幕高度除以item高度，计算处出 viewportFraction
    var screenHeight = MediaQuery.of(context).size.height - topPadding;
    print('screenHeight=$screenHeight');
    var viewportFraction = 200 / screenHeight;

    /// 要跑到顶部去
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: topPadding,
            bottom: 0,
            left: 0,
            right: 0,
            child: Visibility(
              // visible: false,
              visible: true,
              child: PageViewJ(
                itemCount: 10,
                modifier: Modifier(
                    viewportFraction: viewportFraction,
                    scrollDirection: Axis.vertical,
                    initialPage: 0,
                    allowImplicitScrolling: true,
                    clipBehavior: Clip.hardEdge,
                    reverse: false),
                transform: StackTransform(),
                itemBuilder: (BuildContext context, int index) {
                  return _buildChile(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChile(int index) {
    // if (index == 9) {
    //   return Container(
    //     color: Colors.white,
    //     height: 200,
    //   );
    // }

    return Center(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(25),
          ),
          margin: EdgeInsets.only(left: 20, right: 16, bottom: 20),
          width: double.infinity,
          height: 200,
          child: Text("这是文章$index"),
        ),
      ),
    );
  }
}
