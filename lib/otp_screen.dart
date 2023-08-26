import 'dart:convert';
import 'dart:math';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test_video_conference/cache_helper.dart';
import 'package:test_video_conference/common_methods.dart';
import 'package:test_video_conference/constants.dart';
import 'package:test_video_conference/join_meeting%20_screen.dart';
import 'package:test_video_conference/models/response_model.dart';
import 'package:test_video_conference/services/jitsi_meet_service.dart';
import 'package:test_video_conference/widgets/p_appbar.dart';
import 'package:test_video_conference/widgets/p_button.dart';
import 'package:test_video_conference/widgets/p_pin_code.dart';
import 'package:test_video_conference/widgets/p_text.dart';
import 'package:test_video_conference/widgets/p_textfield.dart';


class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? pin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true,
      appBar:appBar(context: context,text:'OTP',isCenter:true),
      body:Column(crossAxisAlignment:CrossAxisAlignment.center,children: [
        const Padding(padding: EdgeInsets.only(top:40,bottom:4),
          child: PText(title:'We sent you a code to', size: PSize.large,fontWeight:FontWeight.w700,),
        ),
        const PText(title:'verify your mobile', size: PSize.large,fontWeight:FontWeight.w700,),
        const PText(title:'number', size: PSize.large,fontWeight:FontWeight.w700,),
        const Padding(
          padding: EdgeInsets.only(top:10,bottom:10),
          child: PText(title:'Enter your OTP code here',fontColor:Constants.grey,size:PSize.small,fontWeight:FontWeight.w300,),
        ),
        Center(child: Padding(padding: const EdgeInsets.only(top:20),
          child: SizedBox(width:MediaQuery.sizeOf(context).width*0.70,
              child: PPinCode(length:4,feedback:(value) async {
                pin=value??'';
                if(pin!.length==4){
                  await CacheHelper.saveData(key: 'pin',value:pin??'');
                  Response res= await JitsiMeetService().sendOTP(mobile:CacheHelper.getData(key:'mobile')??'',otp:pin??'');
                  if(res.statusCode==200||res.statusCode==201){
                    ResponseModel model=   ResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(res.bodyBytes)));
                    if(model.success!=null&&model.success!){
                      handleCallbackMsg(res,context);
                      Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) =>JoinMeetingScreen()));
                    }else{
                      ElegantNotification.error(title: Text('Error'),description: Text(model.msg??'')).show(context);
                    }
                  }
                }
                setState(() {});
              }),
            ),
        ),
        ),
        const Padding(padding: EdgeInsets.only(top:10,bottom:10),
          child: PText(title:'I did\'t received a code!',fontColor:Constants.grey,size:PSize.small,fontWeight:FontWeight.w300,),
        ),
        RichText(text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'Resend Code',style:const TextStyle(color:Constants.yellow),
                  recognizer: TapGestureRecognizer()..onTap = () async {
                    Response res= await JitsiMeetService().sendMobileNumber(mobile:CacheHelper.getData(key: 'mobile'));
                    if(res.statusCode==200||res.statusCode==201){
                      ResponseModel model=   ResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(res.bodyBytes)));
                      handleCallbackMsg(res,context);
                    }
                    }),
            ],
          ),
        )
      ]),
    );
  }
}
