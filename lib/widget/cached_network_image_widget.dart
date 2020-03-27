import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget placeholder;
  final Widget errorWidget;

  CachedNetworkImageWidget({
    Key key,
    @required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.errorWidget,
  }) : assert(imageUrl!=null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: this.imageUrl,
      width: this.width ?? double.infinity,
      height: this.width ?? double.infinity,
      fit: this.fit ?? BoxFit.cover,
//      placeholder: this.placeholder ?? AssetImage('assets/placeholder.png'),
//      errorWidget: ,
    );
  }
}
