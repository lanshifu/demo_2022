main() {
  int? a;
  var length = a?.bitLength;
  a = a ?? 0;
  a = a != 1 ? a : 0;

  ///除（取整）：~/
  print(1 / 2);

  ///0.5
  print(1 ~/ 2);

  print(a is int);
  print(a is! int);
}

class Point {
  num x;
  num y;

  Point(this.x, this.y);

  //重定向构造函数，使用冒号调用其他构造函数
  Point.alongXAxis(num x) : this(x, 0);
}

class Parent {
  int x;
  int y;

  //父类命名构造函数不会传递
  Parent.fromJson(x, y)
      : x = x,
        y = y {
    print('父类命名构造函数');
  }
}

class Child extends Parent {
  int x;
  int y;

  // Child.fromJson(x, y) : super.fromJson(x, y) {
  //   print('Child构造函数');
  // }
  Child.fromJson(x, y)
      : x = x,
        y = y,
        super.fromJson(x, y) {
    print('子类命名构造函`数');
  }

  int get z => x + y;
  set i(int i) => x = i;
}

abstract class IDemo {
  void zhujiang();
}

class DemoImpl implements IDemo {
  @override
  void zhujiang() {}
}

class Demo extends IDemo {
  @override
  void zhujiang() {}
}

///实现call()方法可以让类像函数一样能够被调用。这个很简单，直接上代码：
class ClassFunction {
  call(String a, String b, String c) => '$a $b $c!';

  void testCall() {
    var classFunction = ClassFunction();
    classFunction("", "", "");
  }
}
