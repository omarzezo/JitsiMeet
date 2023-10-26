import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:test_video_conference/cache_helper.dart';
import 'package:test_video_conference/constants.dart';
import 'package:test_video_conference/models/response_model.dart';
import 'package:test_video_conference/screens/send_mobile_screen.dart';
import 'package:test_video_conference/services/jitsi_meet_service.dart';
import 'package:test_video_conference/widgets/p_appbar.dart';
import 'package:test_video_conference/widgets/p_button.dart';
import 'package:test_video_conference/widgets/p_image.dart';
import 'package:test_video_conference/widgets/p_text.dart';
import 'package:test_video_conference/widgets/p_textfield.dart';
// import 'package:uqudosdk_flutter/UqudoIdPlugin.dart';
// import 'package:uqudosdk_flutter/uqudosdk_flutter.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:Constants.white,resizeToAvoidBottomInset: true,
      appBar:appBar(context: context,text:'join_meeting'.tr(),isCenter:true,backBtn:false,actions:[
        _languageWidget()
      ]),
      body: SingleChildScrollView(
        child: Column(mainAxisSize:MainAxisSize.max,
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
             Padding(padding: const EdgeInsets.only(top:14),
              child: PText(title:'intro_first_title'.tr(), size: PSize.large,fontWeight:FontWeight.w700,),
            ),
            // const PText(title:'Meeting', size: PSize.large,fontWeight:FontWeight.w700,),
             Padding(
              padding:const EdgeInsets.only(top:10,bottom:2),
              child: PText(title:'intro_first'.tr(),fontColor:
              Constants.grey,size:PSize.small,fontWeight:FontWeight.w300,),
            ),
            PText(title:'intro_first_2'.tr(),fontColor: Constants.grey,size:PSize.small,fontWeight:FontWeight.w300,),
            SizedBox(width:MediaQuery.sizeOf(context).width*0.90,
              child: Padding(padding: const EdgeInsets.only(top:10),
                child: SizedBox(height:45,
                  child: PButton(onPressed:() {
                    // JitsiMeetService().getFaceToken();
                    Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) =>SendMobileScreen()));
                  },title:'join_meeting'.tr(),fillColor:Constants.black,textColor:Constants.white,style:PStyle.tertiary,),
                ),
              ),
            ),
            const SizedBox(height:120,),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Padding(padding: EdgeInsets.only(top:14),
                child: PText(title: 'Powered by', size: PSize.small,),
              ),const SizedBox(width: 10,),
              Image.asset('assets/img/app_icon.png',fit:BoxFit.contain),
            ],
            ),
            // Expanded(
            //   child: Align(alignment:Alignment.bottomCenter,child: Padding(padding: const EdgeInsets.only(top:14),
            //     child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //         const Padding(padding: EdgeInsets.only(top:14),
            //           child: PText(title: 'Powered by', size: PSize.small,),
            //         ),const SizedBox(width: 10,),
            //         Image.asset('assets/img/app_icon.png',fit:BoxFit.contain),
            //       ],
            //     ),
            //   )),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _languageWidget(){
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          items: [

            DropdownMenuItem<String>(
              value: 'ar',
              child: PText(title: 'العربيه', size: PSize.medium),
            ),
            DropdownMenuItem<String>(
              value: 'en',
              child: PText(title: 'English', size: PSize.medium),
            ),
          ],
          value: null,
          onChanged: (value) {
            if(value == 'en')context.setLocale(Locale('en'));
            else context.setLocale(Locale('ar'));
          },
          // customButton:  PImage("language",height: 22,width: 22,fit: BoxFit.contain,),
          customButton:Padding(padding: const EdgeInsets.symmetric(horizontal:14),
            child: Icon(Icons.language),
          ),
          dropdownStyleData: DropdownStyleData(maxHeight: 200, width: 100,
              padding: null,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white,),
              elevation: 8,
              offset: const Offset(-50, 10)),
          menuItemStyleData:  MenuItemStyleData(height: 30),
        ),
      ),
    );
  }

  // checkFace() async {
  //   String result;
  //   var token = "5b41841f-0c82-4af9-a9d0-a52ec938bf24";
  //   try {
  //     var faceSessionConfiguration = new FaceSessionConfigurationBuilder()
  //         .setToken(token)
  //         .setSessionId("lNQp0yy092O615ssrtqYZQl5")
  //         .setAppearanceMode(AppearanceMode.SYSTEM)
  //         .build();
  //     result = await UqudoIdPlugin.faceSession(faceSessionConfiguration);
  //   } catch (error) {}
  // }
}
