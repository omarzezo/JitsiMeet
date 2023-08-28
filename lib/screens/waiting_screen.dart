import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test_video_conference/cache_helper.dart';
import 'package:test_video_conference/common_methods.dart';
import 'package:test_video_conference/constants.dart';
import 'package:test_video_conference/models/waiting_response_model.dart';
import 'package:test_video_conference/services/jitsi_meet_service.dart';
import 'package:test_video_conference/widgets/p_appbar.dart';
import 'package:test_video_conference/widgets/p_button.dart';
import 'package:test_video_conference/widgets/p_text.dart';
import 'package:url_launcher/url_launcher.dart';


class WaitingScreen extends StatefulWidget {
  final String? name;
  final String? meetingId;
  final bool? isHost;
  const WaitingScreen({super.key, required this.name,required this.isHost,required this.meetingId});
  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  Timer? timer;
  String participantId ='';
  Response? res;
  bool isHost=true;
  @override
  void initState() {
    super.initState();
    dismissLoader();
    timer = Timer.periodic(const Duration(seconds:5), (Timer t) => callMdetail());
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true,
      appBar:appBar(context: context,text:'Join a Meeting',isCenter:true,actions:[
        PButton(onPressed:() {
          if(timer!=null){
            timer?.cancel();
          }
          Navigator.pop(context);
          dismissLoader();
        },title:'Leave',fillColor:Colors.transparent,textColor:Constants.red,style:PStyle.tertiary,)
      ]),
      body:Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16),
          child: Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.center,children: [
            const Padding(padding: EdgeInsets.only(top:40,bottom:4),
              child: PText(title:'Please Wait, the meeting host will let you in soon.', size: PSize.large,fontWeight:
              FontWeight.w400,),
            ),
             Padding(
              padding: const EdgeInsets.only(top:10,bottom:10),
              child: Container(padding: const EdgeInsets.all(14.0),
                decoration: const BoxDecoration(color:Constants.greenN1, shape: BoxShape.circle
                ),child:Center(child: PText(title:(widget.name??'')[0],fontColor:Constants.green,size:PSize.veryLarge,
                  fontWeight:FontWeight.w700,)),
              ),
            ),
            PText(title:widget.name??'',fontColor:Constants.grey,size:PSize.large,
              fontWeight:FontWeight.w300,)
          ]),
        ),
      ),
    );
  }

  callMdetail() async {
    // if((isHost??false)&&(widget.isHost)){
    if(isHost){
      print("herrrrrrrr"+'1');
       res=await JitsiMeetService().joinMeeting(context:context,name:widget.name??'', meetignId:widget.meetingId??'',
          mobile:CacheHelper.getData(key:'mobile')??'', otp: CacheHelper.getData(key:'pin')??'');
      print('object>'+res!.statusCode.toString());
      if(res!=null&&(res!.statusCode==200||res!.statusCode==201)){
        final data = jsonDecode(res!.body);
        final meeting = data['data']['meeting'];
        final config = data['data']['config'];
        final meetingName = meeting['name'];
        final email = meeting['email'];
        final meetingId = meeting['m_id'];
        final conferenceUrl = data['data']['conference_url'];
        final participantId = meeting['participant_id'];
        // String? serverUrl = 'https://ris.opp.gov.om/';
        bool startWithVideoMuted=config['startWithVideoMuted']=='no'?false:true;
        bool startWithAudioMuted=config['startWithAudioMuted']=='no'?false:true;
        dismissLoader();
        String url="https://opp.ijmeet.com/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name??''}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
        print("urlurlurl>>"+url);
        launchUrl(Uri.parse(url),mode:LaunchMode.inAppWebView);
      }else{
        // here is the code  400
        if(res!=null){
        WaitingResponseModel model=   WaitingResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(res!.bodyBytes)));
        isHost=((model.data?.code??'')=='host_waiting');
        }
        // isHost=(model.data?.code??'')=='host_waiting';
      }
    }else{
      // Here is Accept Waiting
      if(res!=null){
      WaitingResponseModel  model=   WaitingResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(res!.bodyBytes)));
       isHost=((model.data?.code??'')=='host_waiting');
       participantId=model.data?.participantId??'';
       Response response=await JitsiMeetService().getStatusParticipant(participantId: participantId);
       if(response.statusCode==200||response.statusCode==201){
         if(timer!=null){timer!.cancel();}
         final data = jsonDecode(response.body);
         final meeting = data['data']['meeting'];
         final config = data['data']['config'];
         final meetingName = meeting['name'];
         final email = meeting['email'];
         final meetingId = meeting['m_id'];
         final conferenceUrl = data['data']['conference_url'];
         final participantId = meeting['participant_id'];
         bool startWithVideoMuted=config['startWithVideoMuted']=='no'?false:true;
         bool startWithAudioMuted=config['startWithAudioMuted']=='no'?false:true;
         dismissLoader();
         Navigator.pop(context);
         dismissLoader();
         String url="https://opp.ijmeet.com/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
         launchUrl(Uri.parse(url),mode:LaunchMode.inAppWebView);
       }
      print("herrrrrrrr"+'2');
      }
    }
  }
}
