import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'package:test_video_conference/cache_helper.dart';
import 'package:test_video_conference/common_methods.dart';
import 'package:test_video_conference/constants.dart';
import 'package:test_video_conference/models/mobile_meeting_response_model.dart';
import 'package:test_video_conference/models/response_model.dart';
import 'package:test_video_conference/screens/join_meeting%20_screen.dart';
import 'package:test_video_conference/services/jitsi_meet_service.dart';
import 'package:test_video_conference/widgets/p_appbar.dart';
import 'package:test_video_conference/widgets/p_button.dart';
import 'package:test_video_conference/widgets/p_pin_code.dart';
import 'package:test_video_conference/widgets/p_text.dart';
import 'package:test_video_conference/widgets/p_textfield.dart';


class OtpScreen extends StatefulWidget {
  final String id;
  String meetingId;
  String mobileNumber;
  OtpScreen({required this.id,required this.mobileNumber,required this.meetingId});
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? pin;
  @override
  void initState() {
    super.initState();
    getMobileNumber();
  }
  void getMobileNumber(){
    if(widget.id.isNotEmpty){
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        MobileMeetingResponseModel model=await JitsiMeetService().getMobileNumberById(id:widget.id,
            lang:context.locale.languageCode);
        widget.meetingId=model.data?.mid??'';
        widget.mobileNumber=model.data?.phone??'';
        setState(() {});
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true,
      appBar:appBar(context: context,text:'OTP',isCenter:true),
      body:Column(crossAxisAlignment:CrossAxisAlignment.center,children: [
         Padding(padding: const EdgeInsets.only(top:40,bottom:4),
          child: PText(title:'send_code'.tr(), size: PSize.large,fontWeight:FontWeight.w700,),
        ),
        PText(title:'send_code_2'.tr(), size: PSize.large,fontWeight:FontWeight.w700,),
        PText(title:'send_code_3'.tr(), size: PSize.large,fontWeight:FontWeight.w700,),
        Padding(
          padding: const EdgeInsets.only(top:10,bottom:10),
          child: PText(title:'send_code_here'.tr(),fontColor:Constants.grey,size:PSize.small,fontWeight:FontWeight.w300,),
        ),
        Center(child: Padding(padding: const EdgeInsets.only(top:20),
          child: SizedBox(width:MediaQuery.sizeOf(context).width*0.70,
              child: PPinCode(length:4,feedback:(value) async {
                pin=value??'';
                if(pin!.length==4){
                  await CacheHelper.saveData(key: 'pin',value:pin??'');
                  Response res= await JitsiMeetService().sendOTP(mobile:widget.mobileNumber.isEmpty?
                  CacheHelper.getData(key:'mobile'):widget.mobileNumber,otp:pin??'',
                      lang:context.locale.languageCode);
                  if(res.statusCode==200||res.statusCode==201){
                    ResponseModel model=   ResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(res.bodyBytes)));
                    if(model.success!=null&&model.success!){
                      handleCallbackMsg(res,context);
                      Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) =>
                          JoinMeetingScreen(meetingId:widget.meetingId,mobileNumber:widget.mobileNumber)));
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
        Padding(padding: const EdgeInsets.only(top:10,bottom:10),
          child: PText(title:'not_received'.tr(),fontColor:Constants.grey,size:PSize.small,fontWeight:FontWeight.w300,),
        ),
        RichText(text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'resend_code'.tr(),style:const TextStyle(color:Constants.yellow),
                  recognizer: TapGestureRecognizer()..onTap = () async {
                    Response res= await JitsiMeetService().sendMobileNumber(
                        mobile:widget.mobileNumber.isEmpty?CacheHelper.getData(key: 'mobile'):widget.mobileNumber,
                    lang:context.locale.languageCode);
                    if(res.statusCode==200||res.statusCode==201){
                      // ResponseModel model=   ResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(res.bodyBytes)));
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
