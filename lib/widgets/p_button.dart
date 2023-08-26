import 'package:flutter/material.dart';
import 'dart:core';


import '../../constants.dart';
import 'p_text.dart';




class PButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String? title;
  final PSize size;
  final PStyle style;
  final List<String>? dropDown;
  final IconData? icon;
  final Color textColor;
  final Color? fillColor;

  const PButton({Key? key, required this.onPressed,this.size = PSize.medium, this.title, this.style = PStyle.secondary, this.icon, this.dropDown, this.textColor = Constants.blue,this.fillColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttonColor = style == PStyle.primary ? Constants.yellow : style == PStyle.secondary ? Constants.blue : Constants.white;
    return   ElevatedButton(onPressed: onPressed,onHover:(m){},

          style: ElevatedButton.styleFrom(backgroundColor: fillColor ?? buttonColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6),
              side:style == PStyle.tertiary ?  const BorderSide(width: 1.0, color: Constants.greyN4) : BorderSide.none),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
              minimumSize: const Size(80, 35)
          ), child:  Row(
      mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              icon != null ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Icon(icon,color: style == PStyle.tertiary ? textColor : Constants.white,size: 20,),
              ) : const SizedBox.shrink(),
              title != null ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: PText(title: title!, size: size,fontColor: style == PStyle.tertiary ? textColor : Constants.white,fontWeight: FontWeight.w600),
              ): const SizedBox.shrink(),

            ],
          ));
  }

}


