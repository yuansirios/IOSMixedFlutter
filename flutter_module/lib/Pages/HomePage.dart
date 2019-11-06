import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String parameStr;

  static const methodChannel = const MethodChannel('channel_home');

  // 获取初始化参数
  _initWithPrama() async {
    try {
      var prama = await methodChannel.invokeMethod('initWithPrama');
      print("parameStr参数获取成功：$prama");
      setState(() {
        parameStr = prama;
      });
    } on PlatformException {
      print("parameStr参数获取失败");
    }
  }

  _pragmaToiOS() async {
    await methodChannel.invokeMethod('pragmaToiOS', '我是参数');
  }

  _pragmaToiOS2() async {
    Map<String, dynamic> map = {
      "code": "200",
      "data": [1, 2, 3]
    };
    await methodChannel.invokeMethod('pragmaToiOS2', map);
  }

  _iOSToFlutter() async {
    dynamic result;
    try {
      result = await methodChannel.invokeMethod('iOSToFlutter');
    } on PlatformException {
      result = "error";
    }
    if (result is String) {
      setState(() {
        parameStr = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initWithPrama();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("初始化参数：$parameStr"),
            FlatButton(
                onPressed: () => _pragmaToiOS(),
                child: Text("传参给iOS")),
            FlatButton(
                onPressed: () => _pragmaToiOS2(),
                child: Text("Map传参给iOS")),
            FlatButton(
                onPressed: () => _iOSToFlutter(),
                child: Text("iOS传参给Flutter")),
          ],
        ),
      ),
    );
  }
}
