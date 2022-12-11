import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScaleList extends StatefulWidget {
  const ScaleList({Key? key}) : super(key: key);

  @override
  State<ScaleList> createState() => _ScaleListState();
}

class _ScaleListState extends State<ScaleList> {
  late final ScrollController controller;
  var offset = 0.0;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    //监听滚动位置
    controller.addListener(() {
      listenScroll();
    });
  }

  void listenScroll() {
    print("offset=${controller.offset}"); //滚动位置
    // if(controller.offset < 1500){
    setState(() {
      offset = controller.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    itemSize = itemSize;
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            color: Colors.blueGrey,
            height: 100,
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              height: 200,
              child: ListView.separated(
                controller: controller,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(vertical: 0),
                itemCount: itemSize,
                // physics: const BouncingScrollPhysics(
                //     parent: AlwaysScrollableScrollPhysics()),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 0,
                    height: 0,
                  );
                },
                itemBuilder: (context, index) {
                  ///第一个放一起听

                  return _buildChile(index);
                },
              ),
            ),
          ),
          Container(
            color: Colors.blueGrey,
            height: 100,
          )
        ],
      ),
    );
  }

  var itemHeight = 200;
  var itemSize = 5;

  Widget _buildChile(int index) {
    itemSize = itemSize;
    if (itemSize - 1 == index) {
      return Container(
        color: Colors.blueGrey,
        height: 480,
        child: GestureDetector(
          onTap: () {
            controller.animateTo(0,
                duration: const Duration(microseconds: 2000),
                curve: Curves.ease);
          },
          child: const Center(
            child: Text('更多16条'),
          ),
        ),
      );
    }

    ///offset 刚开始0，200表示第一个item划出去
    var firstVisiblePosition = offset ~/ itemHeight;

    var currentOffset = offset / itemHeight;
    var topPadding = 0.0;
    var bottomPadding = 0.0;
    var scale = 1.0;
    var alpha = 1.0;

    ///第一个index缩放
    if (firstVisiblePosition == index) {
      scale = (1 - ((offset % itemHeight / 5) / itemHeight));
      alpha = scale * 0.8;
      topPadding = offset % itemHeight;
    }

    /// 第二个index bottomPadding
    if (firstVisiblePosition + 1 == index) {
      /// 第二个缩放，距离顶部 20%开始
      // var topOffset = offset % itemHeight;
      // if (topOffset > (0.8 * itemHeight) && topOffset < itemHeight) {
      //   scale = (1 - (topOffset - (0.8 * itemHeight)) / itemHeight);
      // }
    }

    if (scale < 0.9) {
      scale = 0.9;
    }
    if (scale > 1) {
      scale = 1;
    }
    if (topPadding < 0) {
      topPadding = 0;
    }
    if (topPadding > 200) {
      topPadding = 200;
    }
    if (alpha < 0.1) {
      alpha = 0.1;
    }
    if (alpha > 1) {
      alpha = 1;
    }
    if (bottomPadding < 0) {
      bottomPadding = 0;
    }
    print(
        'index=$index,offset=$offset,firstVisiblePosition=$firstVisiblePosition,scale=$scale,topPadding=$topPadding');
    return Container(
      width: 200,
      height: 200,
      child: OverflowBox(
        alignment: Alignment.center,
        maxHeight: 400,
        child: Container(
          margin: EdgeInsets.only(top: topPadding),
          width: 200,
          height: 200,
          child: Opacity(
            opacity: alpha,
            child: Transform.scale(
              scale: scale,
              child: Container(
                margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(child: Text("这是文章$index")),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
