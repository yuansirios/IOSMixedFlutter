import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'Pages/HomePage.dart';
import 'Pages/DetailPage.dart';
import 'Pages/EnvSetting.dart';

void main() => runApp(
  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _widgetForRoute(window.defaultRouteName),
    )
  );

Widget _widgetForRoute(String route) {
  print("当前route是:$route");
  if (route == '/')route = 'myApp';
  switch (route) {
    case 'myApp':
      return MyApp();
    case 'home':
      return HomePage();
    case 'detail':
      return DetailPage();
    case 'envSetting':
      return EnvSetting();
    default:
      return Scaffold(
          body: Center(
        child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
      ));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: 'Flutter Demo Home Page');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 创建一个给native的channel (类似iOS的通知）
  static const methodChannel = const MethodChannel('channelTest');

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;

      print('flutter的log打印：现在输出count=$_counter');
      // 当个数累积到3的时候给客户端发参数
      if (_counter == 3) {
        _toNativeSomethingAndGetInfo();
      }

      // 当个数累积到5的时候给客户端发参数
      if (_counter == 1002) {
        Map<String, String> map = {"title": "这是一条来自flutter的参数"};
        methodChannel.invokeMethod('toNativePush', map);
      }

      // 当个数累积到8的时候给客户端发参数
      if (_counter == 1005) {
        Map<String, dynamic> map = {
          "content": "flutterPop回来",
          "data": [1, 2, 3, 4, 5]
        };
        methodChannel.invokeMethod('toNativePop', map);
      }
    });
  }

  // 给客户端发送一些东东 , 并且拿到一些东东
  Future<Null> _toNativeSomethingAndGetInfo() async {
    dynamic result;
    try {
      result = await methodChannel.invokeMethod(
          'toNativeSomething', '大佬你点击了1$_counter下');
    } on PlatformException {
      result = 100000;
    }
    setState(() {
      // 类型判断
      if (result is int) {
        _counter = result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'he button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
