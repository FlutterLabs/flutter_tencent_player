import 'package:flutter/material.dart';

class InkWellWidget extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final Color highlightColor;

  InkWellWidget({
    Key key,
    @required this.child,
    @required this.onTap,
    this.highlightColor: Colors.transparent
  }):
    assert(child!=null),
    assert(onTap!=null),
    assert(highlightColor!=null),
    super();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      highlightColor: this.highlightColor,
      child: this.child,
    );
  }
}
