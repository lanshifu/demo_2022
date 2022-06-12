import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: GoodsListPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class GoodsListPage extends StatefulWidget {
  @override
  _GoodsListPageState createState() => _GoodsListPageState();
}

class _GoodsListPageState extends State<GoodsListPage> {
  GlobalKey _key = GlobalKey();
  Offset? _endOffset;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((c) {
      // 获取「购物车」的位置
      _endOffset = (_key.currentContext?.findRenderObject() as RenderBox)
          .localToGlobal(Offset.zero);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('添加购物车'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            return GestureDetector(
                              onTap: (){
                                // 点击的时候获取当前 widget 的位置，传入 overlayEntry
                                var _overlayEntry = OverlayEntry(builder: (_) {

                                  var offset =  (context.findRenderObject() as RenderBox)
                                      .localToGlobal(Offset.zero);
                                  return RedDotPage(
                                    startPosition: offset,
                                    endPosition: _endOffset,
                                  );
                                });
                                // 显示Overlay
                                Overlay.of(context)?.insert(_overlayEntry);
                                // 等待动画结束
                                Future.delayed(Duration(milliseconds: 500), () {
                                  _overlayEntry.remove();
                                });
                              },
                              child: Text(
                                '我是商品名称$index',
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          }
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          return IconButton(
                            icon: Icon(Icons.add_circle_outline),
                            onPressed: () {
                              // 点击的时候获取当前 widget 的位置，传入 overlayEntry
                              var _overlayEntry = OverlayEntry(builder: (_) {

                                var offset =  (context.findRenderObject() as RenderBox)
                                    .localToGlobal(Offset.zero);
                                return RedDotPage(
                                  startPosition: offset,
                                  endPosition: _endOffset,
                                );
                              });
                              // 显示Overlay
                              Overlay.of(context)?.insert(_overlayEntry);
                              // 等待动画结束
                              Future.delayed(Duration(milliseconds: 500), () {
                                _overlayEntry.remove();
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
              itemCount: 100,
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
          Container(
            height: 60,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(
                    Icons.shop_two,
                    key: _key,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


class RedDotPage extends StatefulWidget {
  final Offset? startPosition;
  final Offset? endPosition;

  const RedDotPage({Key? key, this.startPosition, this.endPosition})
      : super(key: key);

  @override
  _RedDotPageState createState() => _RedDotPageState();
}

class _RedDotPageState extends State<RedDotPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller; // 动画 controller
  Animation<double>? _animation; // 动画
  double left = 100; // 小圆点的left（动态计算）
  double top = 0; // 小远点的right（动态计算）

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!);

    // 二阶贝塞尔曲线用值
    var x0 = widget.startPosition!.dx;
    var y0 = widget.startPosition!.dy;

    ///调整第二个点的值，动画路径就不一一
    var x1 = widget.startPosition!.dx - -100;
    var y1 = widget.startPosition!.dy - 0;

    var x2 = widget.endPosition!.dx;
    var y2 = widget.endPosition!.dy;

    _animation!.addListener(() {
      // t 动态变化的值
      var t = _animation!.value;
      if (mounted)
        setState(() {
          left = pow(1 - t, 2) * x0 + 2 * t * (1 - t) * x1 + pow(t, 2) * x2;
          top = pow(1 - t, 2) * y0 + 2 * t * (1 - t) * y1 + pow(t, 2) * y2;
        });
    });

    // 初始化小圆点的位置
    left = widget.startPosition!.dx;
    top = widget.startPosition!.dy;

    // 显示小圆点的时候动画就开始
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    // 用 Stack -> Positioned 来控制小圆点的位置
    return Positioned(
      left: left,
      top: top,
      child: ClipOval(
        child: Container(
          width: 14,
          height: 14,
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}