import 'dart:convert';
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'permission.dart';
import 'validate.dart';

class Utils {

  /// md5加密
  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  /// 隐藏手机号码中间四位
  static String hideMobile(String str) {
    List<String> _str = [];
    _str = str.split('');
    if( str.length > 6 ) {
      for(int i=0; i<_str.length; i++) {
        if( i >= 3 && i <= 6 ) {
          _str[i]  = '*';
        }
      }
    }
    return _str.join('').toString();
  }

  /// 距离格式化
  static String distanceFormat(double distance) {
    String _distanceStr = "";
    if ( distance < 100 ) {
      _distanceStr = "小于100米";
    } else {
      String _distance = (distance / 1000).toStringAsFixed(2);
      _distanceStr = "${_distance}km";
    }
    return _distanceStr;
  }

  /// 拨打电话
  static void callTel(String phoneNo) async {
    String url = 'tel:$phoneNo';
    if (Platform.isAndroid) {
      bool result = await Permission.getInstance().checkAndApplyPermission(PermissionGroup.phone);
      if (!result) return;
    }
    openApp(url);
  }

  /// 发送短信
  static void sendSms(String phoneNo) async {
    String url = 'sms:$phoneNo';
    if (Platform.isAndroid) {
      bool result = await Permission.getInstance().checkAndApplyPermission(PermissionGroup.sms);
      if (!result) return;
    }
    openApp(url);
  }

  /// 使用浏览器打开一个网页
  static void openBrowser(String url) async {
    bool validateUrl = Validate.isUrl(url);
    if (!validateUrl) return;
    openApp(url);
  }

  /// 打开第三方app
  static void openApp(String url) async {
    if (await canLaunch(url)) await launch(url);
  }
}