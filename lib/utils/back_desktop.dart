import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AndroidBackTop {
  static const String CHANNEL = "android/back/desktop";
  static const String eventBackDeskTop = "backDesktop";

  static Future<bool> backDeskTop() async {
    final platform = MethodChannel(CHANNEL);
    try {
      //通知安卓返回，回手机桌面
      await platform.invokeMethod(eventBackDeskTop);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }

    return Future.value(false);
  }
}
