import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:test_video_conference/cache_helper.dart';
import 'package:test_video_conference/common_methods.dart';
import 'package:test_video_conference/constants.dart';
import 'package:test_video_conference/models/response_model.dart';
import 'package:test_video_conference/screens/otp_screen.dart';
import 'package:test_video_conference/services/jitsi_meet_service.dart';
import 'package:test_video_conference/widgets/p_appbar.dart';
import 'package:test_video_conference/widgets/p_button.dart';
import 'package:test_video_conference/widgets/p_text.dart';
import 'package:test_video_conference/widgets/p_textfield.dart';


class SendMobileScreen extends StatefulWidget {
  final String meetingId;
  SendMobileScreen({required this.meetingId});
  @override
  _SendMobileScreenState createState() => _SendMobileScreenState();
}

class _SendMobileScreenState extends State<SendMobileScreen> {
  // String? mobileNumber='71131936';
  String? mobileNumber='';
  Uri? _latestUri;
  Object? _err;
  StreamSubscription? _sub;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final queryParams = _latestUri?.queryParametersAll.entries.toList();
    return Scaffold(resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar:appBar(context: context,text:'join_meeting'.tr(),isCenter:true),
      body:Column(crossAxisAlignment:CrossAxisAlignment.center,children: [
         Padding(padding: const EdgeInsets.only(top:40,bottom:4),
          child: PText(title:'enter_mobile_number'.tr(), size: PSize.large,fontWeight:FontWeight.w700,),
        ),
         // PText(title:'mobile_number'.tr(), size: PSize.large,fontWeight:FontWeight.w700,),
         Padding(
          padding: const EdgeInsets.only(top:10,bottom:10),
          child: PText(title:'receive_for_number'.tr(),fontColor:Constants.grey,size:PSize.small,fontWeight:FontWeight.w300,),
        ),
        Center(child: SizedBox(width:MediaQuery.sizeOf(context).width*0.94,
            // child: PTextField(initialText:mobileNumber,borderRadius:4,fillColor:Constants.greyN3.withOpacity(0.3),hintText:'Enter mobile number', feedback: (value) {
            child: PTextField(borderRadius:4,fillColor:Constants.greyN3.withOpacity(0.3),hintText:'mobile_number'.tr(), feedback: (value) {
              mobileNumber=value;
            }, validator: (value){return null;},),
          ),
        ),
        Center(child: SizedBox(height:44,width:MediaQuery.sizeOf(context).width*0.94,
            child: PButton(onPressed:() async {
              if(mobileNumber!=null&&mobileNumber!.isNotEmpty){
                await CacheHelper.saveData(key: 'mobile',value:mobileNumber);
                Response res= await JitsiMeetService().sendMobileNumber(mobile:mobileNumber??'',
                lang: context.locale.languageCode);
                if(res.statusCode==200||res.statusCode==201){
                  ResponseModel model=   ResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(res.bodyBytes)));
                  handleCallbackMsg(res,context);
                  if(model.success!=null&&model.success!){
                    Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) =>
                        OtpScreen(id:'',meetingId:widget.meetingId,mobileNumber:'',)));
                  }
                }
              }else{
                ElegantNotification.error(title: Text(''),description: Text('Please Enter Mobile Number')).show(context);
              }
            },title:'send_otp'.tr(),fillColor:Constants.black,textColor:Constants.white,style:PStyle.tertiary,),
          ),
        )
      ]),
    );
  }

}
