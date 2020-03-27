import 'package:flutter/material.dart';

class AutoHideKeyboardWidget extends StatelessWidget {
  final Widget child;

  AutoHideKeyboardWidget({Key key, @required this.child}): assert(child!=null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: this.child,
    );
  }
}
