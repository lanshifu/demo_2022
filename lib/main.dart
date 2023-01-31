import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

// import 'src/generated.fair.dart' as g;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FairApp.runApplication(
    _getApp(),
    plugins: {},
  );
}

dynamic _getApp() => FairApp(
      modules: {},
      delegate: {},
      // generated: g.AppGeneratedModule(),
      // child: MyApp(),
      child: MyFairApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        fairProps: {'title': 'Flutter Demo Home Page'},
      ),
    );
  }
}

class MyFairApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: MyHomePage(title: 'Flutter Demo Home Page'),

        /// FairWidget 是用来加载 bundle 资源的容器
        ///
        /// path 参数：需要加载的 bundle 资源文件路径
        /// data 参数：需要传递给动态页面的参数
        home: FairWidget(

            /// path 可以是 assets 目录下的 bundle 资源，也可以是手机存储
            /// 里的 bundle 资源，如果是手机存储里的 bundle 资源需要使用绝对路径
            path: 'assets/bundle/lib_main.fair.json',
            data: {
              /// 此处的 key 必须是 fairProps，不可以自定义
              /// value 是一个 Map 类型的数据，最好是进行 jsonEncode() 操作
              'fairProps': jsonEncode({'title': '你好'})
            }));
  }
}

@FairPatch()
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.fairProps}) : super(key: key);

  dynamic fairProps;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// 定义与 JS 侧交互的参数，只支持 Map 类型的数据
  ///
  /// 需要用 @FairProps() 注解标记
  /// 变量名可以自定义，习惯上命名为 fairProps
  @FairProps()
  var fairProps;

  int _counter = 0;

  @override
  void initState() {
    super.initState();

    /// 需要将 widget.fairProps 赋值给 fairProps
    fairProps = widget.fairProps;
  }

  String getTitle() {
    return fairProps['title'];
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              // 暂不支持 style: Theme.of(context).textTheme.headline4,
              // 可替换成:
              style: TextStyle(
                  fontSize: 40, color: Color(0xffeb4237), wordSpacing: 0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
