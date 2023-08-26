import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:test_video_conference/cache_helper.dart';
import 'package:test_video_conference/constants.dart';
import 'package:test_video_conference/models/response_model.dart';
import 'package:test_video_conference/otp_screen.dart';
import 'package:test_video_conference/send_mobile_screen.dart';
import 'package:test_video_conference/services/jitsi_meet_service.dart';
import 'package:test_video_conference/widgets/p_appbar.dart';
import 'package:test_video_conference/widgets/p_button.dart';
import 'package:test_video_conference/widgets/p_image.dart';
import 'package:test_video_conference/widgets/p_text.dart';
import 'package:test_video_conference/widgets/p_textfield.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:Constants.white,resizeToAvoidBottomInset: true,
      appBar:appBar(context: context,text:'Home',isCenter:true,backBtn:false),
      body: Column(mainAxisSize:MainAxisSize.max,
        children: [
          // PImage(width:MediaQuery.sizeOf(context).width,height:200,"banner_1"),
          Align(alignment:Alignment.topCenter,child: Padding(padding: const EdgeInsets.only(top:14,bottom:10),
            child: Image.asset('assets/img/new_app_logo.png',
              width:MediaQuery.sizeOf(context).width*0.50,fit:BoxFit.contain,),
          )),
          Image.asset('assets/img/banner_1.png',
            width:MediaQuery.sizeOf(context).width,fit:BoxFit.contain,),

          Align(alignment:Alignment.center,child: Padding(padding: const EdgeInsets.only(top:14,bottom:10),
            child: Image.asset('assets/img/banner_2.png',
              width:MediaQuery.sizeOf(context).width*0.84,fit:BoxFit.contain,),
          )),
          const Padding(padding: EdgeInsets.only(top:14),
            child: PText(title:'Easy & quick join', size: PSize.large,fontWeight:FontWeight.w700,),
          ),
          const PText(title:'Meeting', size: PSize.large,fontWeight:FontWeight.w700,),
          const Padding(
            padding: EdgeInsets.only(top:10,bottom:2),
            child: PText(title:'Ijmeet lets you make video calls, voice calls',fontColor:
            Constants.grey,size:PSize.small,fontWeight:FontWeight.w300,),
          ),
          const PText(title:'with friends and colleague',fontColor: Constants.grey,size:PSize.small,fontWeight:FontWeight.w300,),
          SizedBox(width:MediaQuery.sizeOf(context).width*0.90,
            child: Padding(padding: const EdgeInsets.only(top:10),
              child: PButton(onPressed:() {
                // Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) =>JoinMeetingScreen()));
                Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) =>SendMobileScreen()));
                // Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) =>OtpScreen()));
              },title:'Join meeting',fillColor:Constants.black,textColor:Constants.white,style:PStyle.tertiary,),
            ),
          ),

          Expanded(
            child: Align(alignment:Alignment.bottomCenter,child: Padding(padding: const EdgeInsets.only(top:14),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Padding(padding: EdgeInsets.only(top:14),
                    child: PText(title: 'Powered by', size: PSize.small,),
                  ),const SizedBox(width: 10,),
                  Image.asset('assets/img/app_icon.png',fit:BoxFit.contain),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}
