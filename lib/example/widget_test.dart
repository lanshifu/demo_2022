import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StatelessWidgetTest extends StatelessWidget {
  const StatelessWidgetTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: const StatefulWidgetTest());
  }
}

class StatefulWidgetTest extends StatefulWidget {
  const StatefulWidgetTest({Key? key}) : super(key: key);

  @override
  State<StatefulWidgetTest> createState() => _StatefulWidgetTestState();
}

class _StatefulWidgetTestState extends State<StatefulWidgetTest> {
  //定义一个globalKey, 由于GlobalKey要保持全局唯一性，我们使用静态变量存储
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    //初始化状态
    print("initState");
    if (defaultTargetPlatform == TargetPlatform.android) {
      // 是安卓系统，do something
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("Context测试"),
      ),
      body: Column(
        children: [
          const Text("Context"),
          ElevatedButton(
            onPressed: () {
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("我是SnackBar")),
              );
            },
            child: const Text("snackBar"),
          ),
          ElevatedButton(
            onPressed: () {
              // 查找父级最近的Scaffold对应的ScaffoldState对象
              ScaffoldState? _state =
                  context.findAncestorStateOfType<ScaffoldState>();
              print("_state=$_state"); //null？
              // 打开抽屉菜单
              _state?.openDrawer();

              _globalKey.currentState?.openDrawer();
            },
            child: const Text("打开抽屉"),
          ),
          Container(
            child: Builder(
              builder: (context) {
                // 在 widget 树中向上查找最近的父级`Scaffold`  widget
                Scaffold? scaffold =
                    context.findAncestorWidgetOfExactType<Scaffold>();
                // 直接返回 AppBar的title， 此处实际上是Text("Context测试")
                return (scaffold?.appBar as AppBar).title ?? const Text("text");
              },
            ),
          ),
        ],
      ),
      drawer: const Drawer(),
    );
  }

  @override
  void didUpdateWidget(StatefulWidgetTest oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget ");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble， 热重载会调用？");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}
