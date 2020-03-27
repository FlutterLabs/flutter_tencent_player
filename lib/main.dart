import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'provider/app_theme_provider.dart';
import 'provider/application_provider.dart';
import 'views/IndexPage.dart';

void main() {
  runApp(Application());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class Application extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_) => ApplicationProvider()),
      ],
      child: Consumer<AppThemeProvider>(
        builder: (_, v, __) {
          return MaterialApp(
//            showPerformanceOverlay: true, //显示性能标签
            debugShowCheckedModeBanner: false,
            darkTheme: v.themeData(isDarkMode: true),
            theme: v.themeData(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('zh', 'CH'),
              Locale('en', 'US')
            ],
            home: Consumer<ApplicationProvider>(
              builder: (_, m, __) {
                print("是否第一次打开app：${m.firstStartRunApp}");
//                return m.firstStartRunApp ? GuidPage() : IndexPage();
                return IndexPage();
              },
            ),
            builder: (context, child) {
              /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // 或者 MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1.0),
                child: child,
              );
            },
          );
        },
      ),
    );
  }
}
