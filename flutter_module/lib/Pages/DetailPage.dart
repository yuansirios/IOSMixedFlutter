import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String parameStr;

  EventChannel eventChannel =
      EventChannel("channel_detail", const StandardMethodCodec());

  @override
  void initState() {
    super.initState();
    _initWithPrama();
  }

// 初始化传参
  _initWithPrama() {
    eventChannel.receiveBroadcastStream("init").listen((Object value) {
      print("init:$value");
      if (value is String) {
        setState(() {
          parameStr = value.toString();
        });
      } else {
        print("init:参数格式异常");
      }
    }, onError: (dynamic a) {
      print("init:参数接收失败");
    });
  }

  _pragmaToiOS() {
    Map map = {
      "pramaToiOS": {"key": parameStr}
    };
    eventChannel.receiveBroadcastStream(map).listen(null, onDone: () {
      print("pramaToiOS:参数传输成功");
    }, onError: (dynamic a) {
      print("pramaToiOS:参数传输失败");
    });
  }

  _iOSToFlutter() {
    eventChannel.receiveBroadcastStream("iOSToFlutter").listen((Object value) {
      print("$value");
      if (value is String) {
        setState(() {
          parameStr = value.toString();
        });
      } else {
        print("iOSToFlutter:参数格式异常");
      }
    }, onError: (dynamic a) {
      print("iOSToFlutter:参数接收失败");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            // color: Colors.red,
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
          Image.asset("images/a.png"),
          Text("初始化参数：$parameStr", style: TextStyle(fontFamily: "fzsj")),
          FlatButton(onPressed: () => _pragmaToiOS(), child: Text("Map传参给iOS")),
          FlatButton(
              onPressed: () => _iOSToFlutter(), child: Text("iOS传参给Flutter")),
        ]))));
  }
}
