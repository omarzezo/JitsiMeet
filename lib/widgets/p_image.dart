import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_video_conference/constants.dart';

class PImage extends StatelessWidget {
  final String imageName;
  final String? label;
  final Color? color;
  final bool hasColor;
  final double? height,width;
  final BoxFit fit;
  const PImage(this.imageName,{Key? key,this.hasColor=false,this.color, this.height, this.width, this.fit = BoxFit.cover, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SvgPicture.asset(
        "assets/img/$imageName.svg",
        // color:hasColor?null: (color ?? Constants.grey),
        fit: fit,
        height: height,
        width: width,
        semanticsLabel: label
    );
  }

}