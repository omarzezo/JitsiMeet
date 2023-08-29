import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_video_conference/cache_helper.dart';
import 'package:test_video_conference/common_methods.dart';
import 'package:test_video_conference/constants.dart';
import 'package:test_video_conference/models/waiting_response_model.dart';
import 'package:test_video_conference/screens/waiting_screen.dart';
import 'package:test_video_conference/services/jitsi_meet_service.dart';
import 'package:test_video_conference/widgets/p_appbar.dart';
import 'package:test_video_conference/widgets/p_button.dart';
import 'package:test_video_conference/widgets/p_text.dart';
import 'package:test_video_conference/widgets/p_textfield.dart';
import 'package:url_launcher/url_launcher.dart';


class JoinMeetingScreen extends StatefulWidget {
  @override
  _JoinMeetingScreenState createState() => _JoinMeetingScreenState();
}

class _JoinMeetingScreenState extends State<JoinMeetingScreen> {
  String? name,meetingId;

  Future callPermission() async {
    // await Permission.camera.request();
    // await Permission.microphone.request();
    // await Permission.audio.request();
    await askCameraPermission();
    await askMicrophonePermission();
    // await askAudioPermission();
  }
  @override
  void initState() {
    super.initState();
    callPermission();
  }
  Future<bool> askAudioPermission() async{
    PermissionStatus status = await Permission.audio.request();
    if(status.isDenied == true) {
      askAudioPermission();
    } else {
      return true;
    }
    return false;
  }
  Future<bool> askMicrophonePermission() async{
    PermissionStatus status = await Permission.microphone.request();
    if(status.isDenied == true) {
      askMicrophonePermission();
    } else {
      return true;
    }
    return false;
  }
  Future<bool> askCameraPermission() async{
    PermissionStatus status = await Permission.camera.request();
    if(status.isDenied == true) {
      askCameraPermission();
    } else {
      return true;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true,
      appBar:appBar(context: context,text:'Join a Meeting',isCenter:true),
      body:Column(crossAxisAlignment:CrossAxisAlignment.center,children: [
        Center(child: Padding(padding: const EdgeInsets.only(top:40),
          child: SizedBox(width:MediaQuery.sizeOf(context).width*0.94,
            child: PTextField(borderRadius:4,fillColor:Constants.greyN3.withOpacity(0.3),hintText:'Enter Name', feedback: (value) {
              name=value;
            }, validator: (value){return null;},),
          ),
        ),
        ),
        Center(child: SizedBox(width:MediaQuery.sizeOf(context).width*0.94,
          child: PTextField(borderRadius:4,fillColor:Constants.greyN3.withOpacity(0.3),hintText:'Meeting ID', feedback: (value) {
            meetingId=value;
          }, validator: (value){return null;},),
        ),
        ),
        Center(child: SizedBox(height:44,width:MediaQuery.sizeOf(context).width*0.94,
          child: PButton(onPressed:() async {
            // Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) =>WebViewScreen()));
            if(name!=null&&meetingId!=null){
              Response res=await JitsiMeetService().joinMeeting(context:context,name: name??'', meetignId:meetingId??'',
              // JitsiMeetService().joinMeeting(name: 'Ahmed', meetignId:'c4fc911',
                  mobile:CacheHelper.getData(key:'mobile')??'', otp: CacheHelper.getData(key:'pin')??'');
              print('object>'+res.statusCode.toString());
              if(res.statusCode==200||res.statusCode==201){
                final data = jsonDecode(res.body);
                final meeting = data['data']['meeting'];
                final config = data['data']['config'];
                final meetingName = meeting['name'];
                final email = meeting['email'];
                final meetingId = meeting['m_id'];
                final conferenceUrl = data['data']['conference_url'];
                final participantId = meeting['participant_id'];
                // String? serverUrl = "https://" + conferenceUrl + "/";
                String? serverUrl = 'https://worlditevents.com/';
                // String? serverUrl = 'https://ris.opp.gov.om/';
                bool startWithVideoMuted=config['startWithVideoMuted']=='no'?false:true;
                bool startWithAudioMuted=config['startWithAudioMuted']=='no'?false:true;
                dismissLoader();
                // String url="https://opp.ijmeet.com/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=$name&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
                String url="https://interrog.opp.gov.om/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=$name&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
                print("urlurlurl>>"+url);
                launchUrl(Uri.parse(url),mode:LaunchMode.inAppWebView);
              }else{
                // here is the code  400
                WaitingResponseModel model=   WaitingResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(res.bodyBytes)));
                bool isHost=(model.data?.code??'')=='host_waiting';
                Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) =>WaitingScreen(
                    meetingId:meetingId,
                    name:name??'',
                    isHost:isHost)));
              }
            }
          },title:'Join Meeting',fillColor:Constants.black,textColor:Constants.white,style:PStyle.tertiary,),
        ),
        )
      ]),
    );
  }
}
