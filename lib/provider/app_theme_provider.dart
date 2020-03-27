import 'package:flutter/material.dart';
import 'package:fluttertencentplayer/common/sp_util.dart';

class AppThemeProvider with ChangeNotifier {
  String _spName = "appTheme";

  static const Map<ThemeMode, String> themes = {
    ThemeMode.dark: 'Dark',
    ThemeMode.light : 'Light',
    ThemeMode.system : 'System'
  };

  /// 主题同步
  void syncTheme() {
    String theme = SpUtil.getString(this._spName);
    if (theme.isNotEmpty && theme != themes[ThemeMode.system]) {
      notifyListeners();
    }
  }

  /// 设置主题
  void setTheme(ThemeMode themeMode) {
    SpUtil.putString(this._spName, themes[themeMode]);
    notifyListeners();
  }

  /// 获取主题模式
  ThemeMode getThemeMode(){
    String theme = SpUtil.getString(this._spName);
    switch(theme) {
      case 'Dark':
        return ThemeMode.dark;
      case 'Light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  /// 获取主题
  themeData({bool isDarkMode: false}) {
    return ThemeData(
//      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.blue,
      splashColor: Colors.transparent,
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xff58bd6a),
        splashColor: Colors.transparent,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.white,
        textTheme: TextTheme(
          subtitle1: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff33333))
        ),
        elevation: 0,
        brightness: Brightness.light,
//        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
    );
  }
}