import 'package:flutter/material.dart';
import '../../constants.dart';
import 'p_image.dart';
import 'p_text.dart';


AppBar appBar({Function()? onBack,String? text, bool isCenter = false,bool backBtn = true,required BuildContext context,List<Widget>? actions,
  refreshCheck=true,double? elevation,Widget? titleWidget}){
  return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      centerTitle: isCenter,titleSpacing: 0,bottomOpacity: 0,
      elevation: elevation ?? 0.3,
      backgroundColor: Constants.white,title: Padding(
        padding: const EdgeInsets.only(right:0),
        child: Row(
    mainAxisAlignment:isCenter? MainAxisAlignment.center:MainAxisAlignment.start,
    children: [
        if(text == null)const PImage("Logo (2)",width: 30,height: 30,fit: BoxFit.scaleDown),
        if(text != null) titleWidget ?? PText(title: text, size: PSize.large,fontColor: Constants.black,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis),
    ],
  ),
      ),
      leading: backBtn ? IconButton(onPressed: (){
        if(onBack!=null){
          onBack();
        }else{Navigator.pop(context,refreshCheck);}
      },
          icon: const Icon(Icons.arrow_back_ios,color: Constants.yellow)) : null,
  actions: actions);


}

