import 'package:flutter/material.dart';
import 'package:fluttertencentplayer/common/sp_util.dart';
import 'package:package_info/package_info.dart';

class ApplicationProvider with ChangeNotifier {
  String appName = "";
  String appVersion = "";
  String appBuildVersion = "";
  String appPackageName = "";
  bool firstStartRunApp = true;

  ApplicationProvider() {
    this.initData();
  }

  /// 初始化数据，获得app信息
  void initData() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    this.appName = packageInfo.appName;
    this.appVersion = packageInfo.version;
    this.appBuildVersion = packageInfo.buildNumber;
    this.appPackageName = packageInfo.packageName;
    this.firstStartRunApp = SpUtil.getBool("firstStartRunApp", defValue: true);
    notifyListeners();
  }

  /// 设置第一次启动app为否
  void setFirstStartRunApp() {
    this.firstStartRunApp = false;
    SpUtil.putBool("firstStartRunApp", false);
    notifyListeners();
  }
}