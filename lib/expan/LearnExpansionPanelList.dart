import 'package:flutter/material.dart';

class LearnExpansionPanelList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LearnExpansionPanelList();
  }
}

class _LearnExpansionPanelList extends State<LearnExpansionPanelList>
    with TickerProviderStateMixin {
  var currentPanelExpand = false; //设置-1默认全部闭合

  late final AnimationController controller;
  late Animation<double> _reaction;
  var isOpenAnim = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      value: currentPanelExpand ? 1.0 : 0.0,
      vsync: this,
    );
    _reaction = CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    );
    _reaction.addListener(() {
      _listener();
    });
  }

  _listener() {
    setState(() {
      if (isOpenAnim && _reaction.value >= 0.7) {
        currentPanelExpand = true;
      }

      if (!isOpenAnim && _reaction.value >= 0.7) {
        currentPanelExpand = false;
      }
    });
  }

  void startOpenAnim() {
    controller.reset();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var listHeight = 800.0;
    var listBottom = listHeight * _reaction.value;
    if (listBottom < 200) {
      listBottom = 200;
    }
    if (!isOpenAnim) {
      listBottom = listHeight - listBottom;
    }
    // if (_reaction.value == 0.0) {
    //   currentPanelExpand = false;
    // }
    print('_reaction = ${_reaction.value},listBottom=$listBottom');
    return Container(
      child: Stack(
        children: <Widget>[
          Visibility(
            visible: !currentPanelExpand,
            child: Container(
              margin: EdgeInsets.only(top: 30),
              height: 206,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 20,
                    right: 20,
                    left: 20,
                    child: Opacity(opacity: 0.8, child: _buildItem(0)),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Opacity(opacity: 0.9, child: _buildItem(0)),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildItem(0),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: !currentPanelExpand,
            child: Positioned(
              left: 0,
              right: 0,
              top: 166,
              child: GestureDetector(
                onTap: () {
                  /// 展开动画
                  startOpenAnim();
                  isOpenAnim = true;
                  setState(() {
                    currentPanelExpand = true;
                  });
                },
                child: Container(
                  child: Center(
                    child: Text(
                      '展开（2条申请）',
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: currentPanelExpand,
            child: Container(
              margin: EdgeInsets.only(top: 0),
              height: listBottom,
              child: ListView(
                shrinkWrap: false,
                children: [
                  _buildItem(0),
                  _buildItem(0),
                  _buildItem(0),
                  _buildItem(0),
                  _buildItem(0),
                  _buildItem(0),
                ],
              ),
            ),
          ),
          Visibility(
            visible: currentPanelExpand,
            child: Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  /// 收起动画

                  startOpenAnim();
                  isOpenAnim = false;
                },
                child: Container(
                  child: Center(
                    child: Text('收起',
                        style: TextStyle(color: Colors.red, fontSize: 20)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // WidgetAnimItem(int index) {
  //   return FadeTransition(
  //       opacity: Tween<double>(
  //         begin: 0,
  //         end: 1,
  //       ).animate(
  //         CurvedAnimation(parent: animation, curve: Curves.elasticInOut),
  //       ),
  //       child: _buildItem(index));
  // }

  Widget _buildItem(int index) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      width: 335,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 56,
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      color: Colors.black12,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          '用户',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '申请开麦说话',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
