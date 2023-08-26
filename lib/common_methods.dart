
import 'dart:convert';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';

showLoader({bool canInteract = true}){
  EasyLoading.instance.userInteractions = canInteract;
  // EasyLoading.instance.userInteractions = false;
  EasyLoading.instance.maskType = EasyLoadingMaskType.clear;
  if(EasyLoading.isShow){
    // EasyLoadings.dismiss();
    EasyLoading.show();
    print("Nooooooooooo");
  }else{
    print("yessssssss");
    EasyLoading.show();
  }
}

dismissLoader(){
  if(EasyLoading.isShow){
    EasyLoading.dismiss();
  }
}

Future<void> handleCallbackMsg(Response response,BuildContext context)async {
  String msg =jsonDecode(const Utf8Decoder().convert(response.bodyBytes))['msg'];
  // String status =jsonDecode(const Utf8Decoder().convert(response.bodyBytes))['Status'];
  if (response.statusCode==200||response.statusCode==201) {
    ElegantNotification.success(title: Text(''),description: Text(msg),toastDuration: const
    Duration(milliseconds: 1500),displayCloseButton: false,onActionPressed: (){},onDismiss: (){},
      width:MediaQuery.of(context).size.width,).show(context);
  } else {
    // List<String> error=[];
    // jsonDecode(const Utf8Decoder().convert(response.bodyBytes))['Errors'].forEach((item){
    //   error.add(item['errorMsg']);
    // });
    ElegantNotification.error(title: Text(''),description: Text(msg)).show(context);
  }
}