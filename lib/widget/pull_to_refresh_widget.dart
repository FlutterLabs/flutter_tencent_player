import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullToRefreshWidget extends StatelessWidget {
  final RefreshController controller;
  final Widget child;
  final Function onRefresh;
  final Function onLoading;
  final bool enablePullDown;
  final bool enablePullUp;

  PullToRefreshWidget({
    Key key,
    @required this.controller,
    @required this.child,
    this.onRefresh,
    this.onLoading,
    this.enablePullDown: true,
    this.enablePullUp: false
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: this.controller,
      header: ClassicHeader(
        idleText: '下拉可以刷新',
        completeText: '刷新完毕',
        completeIcon: null,
        refreshingIcon: CupertinoActivityIndicator(),
        refreshingText: '正在刷新数据中',
        releaseText: '松开立即刷新',
      ),
      footer: ClassicFooter(
        loadingText: '数据加载中',
        idleText: '上拉加载更多数据',
        noDataText: '亲，到底啦！',
        loadingIcon: CupertinoActivityIndicator(),
      ),
      onRefresh: () {
        if (this.onRefresh!= null) this.onRefresh();
      },
      onLoading: () {
        if (this.onLoading!= null) this.onLoading();
      },
      enablePullDown: this.enablePullDown,
      enablePullUp: this.enablePullUp,
      child: this.child,
    );
  }
}
