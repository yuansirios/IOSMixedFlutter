import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Component/AppConfig.dart';

class EnvSetting extends StatefulWidget {
  @override
  _EnvSettingState createState() => _EnvSettingState();
}

class _EnvSettingState extends State<EnvSetting> {
  String envStr;

  static const methodChannel = const MethodChannel('channel_env');

  // 设置当前环境
  _setUpENV() async {
    try {
      String env = await methodChannel.invokeMethod('setUpENV');
      print("环境参数获取成功：$env");
      if (env == 'dev') AppConfig.env = EnvType.EnvType_Dev;
      if (env == 'test') AppConfig.env = EnvType.EnvType_Test;
      if (env == 'release') AppConfig.env = EnvType.EnvType_Release;

      setState(() {
        envStr = AppConfig.appName;
      });
    } catch (e) {
      print("环境参数获取失败");
    }
  }

  @override
  void initState() {
    super.initState();
    _setUpENV();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 200,
        color: Colors.green,
        child: Column(
          children: <Widget>[
            Container(
              width: 200,
              height: 100,
              child: Image.asset("images/b.png"),
            ),
            Text("现在是：$envStr"),
            Text("主机地址：${AppConfig.apiHost}"),
          ],
        ),
      ),
    ));
  }
}
