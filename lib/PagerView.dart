import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PagerView extends StatefulWidget {
  const PagerView({Key? key}) : super(key: key);

  @override
  State<PagerView> createState() => _PagerViewState();
}

class _PagerViewState extends State<PagerView> {
  late PageController pageController;

  double pageOffset = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.3)
      ..addListener(() {
        listenScroll();
      });
  }

  void listenScroll() {
    pageOffset = pageController.page ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constrains) {
        return PageView.builder(
          scrollDirection: Axis.vertical,
          controller: pageController,
          itemCount: 5,
          itemBuilder: (context, index) {
            // return your view for pageview
            return _buildChile(index);
          },
        );
      }),
    );
  }

  var itemHeight = 200;
  var itemSize = 5;

  Widget _buildChile(int index) {
    return Container(
      width: 200,
      height: 200,
      child: Opacity(
        opacity: 1,
        child: Transform.scale(
          scale: pageOffset - index,
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
    );
  }
}
