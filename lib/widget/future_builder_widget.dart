
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureBuilderWidget<T> extends StatelessWidget {
  final Future future;
  final Widget child;
  final Widget error;
  final Widget loading;
  final Function onRefresh;

  FutureBuilderWidget({
    Key key,
    @required this.future,
    @required this.child,
    this.error,
    this.loading,
    this.onRefresh
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: this.future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // 请求已结束
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // 请求失败，显示错误
            return this.error != null ? this.error : _NetworkErrorWidget(onPressed: this.onRefresh);
          } else {
            // 请求成功，显示数据
            return this.child;
          }
        } else {
          // 请求未结束，显示loading
          return this.loading != null ? this.loading : _LoadingWidget();
        }
      },
    );
  }

}

/// 等待加载widget
class _LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CupertinoActivityIndicator(),);
  }
}

/// 网络错误widget
class _NetworkErrorWidget extends StatelessWidget {
  final String errorMsg;
  final Function onPressed;

  _NetworkErrorWidget({
    Key key,
    this.errorMsg,
    this.onPressed
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/network_error.png", width: 140, height: 140,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Text(this.errorMsg ?? "网络好像出陆一些问题", style: TextStyle(
              fontSize: 14,
              color: Color(0xffb1b1b1)
            ),),
          ),
          Container(
            width: 160,
            height: 36,
            child: OutlineButton(
              color: Color(0xffb1b1b1),
              child: Text("重新加载", style: TextStyle(fontSize: 14, color: Color(0xffb1b1b1)),),
              onPressed: onPressed,
            ),
          )
        ]
      )
    );
  }
}

