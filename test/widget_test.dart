// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:demo_2022/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);

    dynamic t;
    Object x;
    t = "hi world";
    x = 'Hello Object';
//下面代码没有问题
    t = 1000;
    x = 1000;

    var yyy = Coordinate();
    print(yyy is Point); //true
    print(yyy is Coordinate); //true

    var dog = Dog();
    dog
      ..eat()
      ..walk();

    var man = Man();
    man
      ..eat()
      ..walk()
      ..say()
      ..code();

    Future.wait([
      // 2秒后返回结果
      Future.delayed(Duration(seconds: 2), () {
        return "hello";
      }),
      // 4秒后返回结果
      Future.delayed(Duration(seconds: 4), () {
        return " world";
      })
    ]).then((results) {
      print(results[0] + results[1]);
    }).catchError((e) {
      print(e);
    });
  });
}

class Point {}

class Coordinate with Point {}

class Person {
  say() {
    print('say');
  }
}

mixin Eat {
  eat() {
    print('eat');
  }
}

mixin Walk {
  walk() {
    print('walk');
  }
}

mixin Code {
  code() {
    print('key');
  }
}

class Dog with Eat, Walk {}

class Man extends Person with Eat, Walk, Code {}
