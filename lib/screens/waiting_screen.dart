import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test_video_conference/cache_helper.dart';
import 'package:test_video_conference/common_methods.dart';
import 'package:test_video_conference/constants.dart';
import 'package:test_video_conference/models/user_data_response_model.dart';
import 'package:test_video_conference/models/waiting_response_model.dart';
import 'package:test_video_conference/screens/web_view_screen.dart';
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
  Timer? statusTimer,mDetailTimer;
  String participantId ='';
  Response? res;
  bool isHost=true;
  @override
  void initState() {
    super.initState();
    dismissLoader();
    // timer   = Timer.periodic(const Duration(seconds:15), (Timer t) => callMdetail());
    Future.delayed(Duration.zero, () {
      callMeetingDetail();
    });
  }
  @override
  void dispose() {
    statusTimer?.cancel();
    mDetailTimer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true,
      appBar:appBar(context: context,text:'join_meeting'.tr(),isCenter:true,actions:[
        // PButton(onPressed:() {
        //   if(timer!=null){
        //     timer?.cancel();
        //   }
        //   Navigator.pop(context);
        //   dismissLoader();
        // },title:'Leave',fillColor:Colors.transparent,textColor:Constants.red,style:PStyle.tertiary,)
      ],),
      body:Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16),
          child: Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.center,children: [
             Padding(padding: const EdgeInsets.only(top:40,bottom:4),
              child: PText(title:'please_wait'.tr(), size: PSize.large,fontWeight:
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

  // callMdetail() async {
  //   // if((isHost??false)&&(widget.isHost)){
  //   if(isHost){
  //     print("herrrrrrrr"+'1');
  //      res=await JitsiMeetService().joinMeeting(context:context,name:widget.name??'', meetignId:widget.meetingId??'',
  //         mobile:CacheHelper.getData(key:'mobile')??'', otp: CacheHelper.getData(key:'pin')??'');
  //     print('object>'+res!.statusCode.toString());
  //     if(res!=null&&(res!.statusCode==200||res!.statusCode==201)){
  //       final data = jsonDecode(res!.body);
  //       final meeting = data['data']['meeting'];
  //       final config = data['data']['config'];
  //       final meetingName = meeting['name'];
  //       final email = meeting['email'];
  //       final meetingId = meeting['m_id'];
  //       final conferenceUrl = data['data']['conference_url'];
  //       final participantId = meeting['participant_id'];
  //       // String? serverUrl = 'https://ris.opp.gov.om/';
  //       bool startWithVideoMuted=config['startWithVideoMuted']=='no'?false:true;
  //       bool startWithAudioMuted=config['startWithAudioMuted']=='no'?false:true;
  //       dismissLoader();
  //       String url="https://opp.ijmeet.com/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name??''}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //       // String url="https://testinterrog.opp.gov.om/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name??''}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //       // String url="https://interrog.opp.gov.om/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name??''}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //       print("urlurlurl>>"+url);
  //       // launchUrl(Uri.parse(url),mode:LaunchMode.inAppWebView);
  //       Navigator.pop(context);
  //       if(Platform.isAndroid){
  //       Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) =>
  //           PublicWebViewScreen(url: url, name: widget.name??''))).then((value){
  //         // Navigator.pop(context);
  //         // Navigator.pop(context);
  //         // Navigator.pop(context);
  //       });}else{
  //         launchUrl(Uri.parse(url),mode:LaunchMode.inAppWebView);
  //       }
  //     }else{
  //       // here is the code  400
  //       if(res!=null){
  //       WaitingResponseModel model=   WaitingResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(res!.bodyBytes)));
  //       isHost=((model.data?.code??'')=='host_waiting');
  //       }
  //       // isHost=(model.data?.code??'')=='host_waiting';
  //     }
  //   }else{
  //     // Here is Accept Waiting
  //     if(res!=null){
  //     WaitingResponseModel  model=   WaitingResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(res!.bodyBytes)));
  //      isHost=((model.data?.code??'')=='host_waiting');
  //      participantId=model.data?.participantId??'';
  //      if(participantId.isEmpty){
  //        res=await JitsiMeetService().joinMeeting(context:context,name:widget.name??'', meetignId:widget.meetingId??'',
  //            mobile:CacheHelper.getData(key:'mobile')??'', otp: CacheHelper.getData(key:'pin')??'');
  //      }
  //      Response response=await JitsiMeetService().getStatusParticipant(participantId: participantId,
  //          lang:context.locale.languageCode);
  //      if(response.statusCode==200||response.statusCode==201){
  //        if(timer!=null){timer!.cancel();}
  //        final data = jsonDecode(response.body);
  //        final meeting = data['data']['meeting'];
  //        final config = data['data']['config'];
  //        final meetingName = meeting['name'];
  //        final email = meeting['email'];
  //        final meetingId = meeting['m_id'];
  //        final conferenceUrl = data['data']['conference_url'];
  //        final participantId = meeting['participant_id'];
  //        bool startWithVideoMuted=config['startWithVideoMuted']=='no'?false:true;
  //        bool startWithAudioMuted=config['startWithAudioMuted']=='no'?false:true;
  //        dismissLoader();
  //        String url="https://opp.ijmeet.com/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //        // String url="https://testinterrog.opp.gov.om/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //        // String url="https://interrog.opp.gov.om/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //        // launchUrl(Uri.parse(url),mode:LaunchMode.externalApplication);
  //        Navigator.pop(context);
  //        if(Platform.isAndroid){
  //          Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) =>
  //              PublicWebViewScreen(url: url, name: widget.name??''))).then((value){
  //            // Navigator.pop(context);
  //            // Navigator.pop(context);
  //            // Navigator.pop(context);
  //          });
  //        }else{
  //          launchUrl(Uri.parse(url),mode:LaunchMode.inAppWebView);
  //        }
  //      }else{
  //        WaitingResponseModel  model=   WaitingResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));
  //        if((model.data?.code??'')=='reject_user'){
  //          if(timer!=null){timer!.cancel();}
  //          dismissLoader();
  //          Navigator.pop(context);
  //          ElegantNotification.error(title: Text(''),description: Text((model.msg??''))).show(context);
  //        }
  //      }
  //     print("herrrrrrrr"+'2');
  //     }
  //   }
  // }

  // callMdetail2() async {
  //   if(isHost){
  //     res=await JitsiMeetService().joinMeeting(context:context,name:widget.name??'', meetignId:widget.meetingId??'',
  //         mobile:CacheHelper.getData(key:'mobile')??'', otp: CacheHelper.getData(key:'pin')??'');
  //     if(res!=null&&(res!.statusCode==200||res!.statusCode==201)){
  //       final data = jsonDecode(res!.body);
  //       final meeting = data['data']['meeting'];
  //       final config = data['data']['config'];
  //       final meetingName = meeting['name'];
  //       final meetingId = meeting['m_id'];
  //       final conferenceUrl = data['data']['conference_url'];
  //       final participantId = meeting['participant_id'];
  //       bool startWithVideoMuted=config['startWithVideoMuted']=='no'?false:true;
  //       bool startWithAudioMuted=config['startWithAudioMuted']=='no'?false:true;
  //       dismissLoader();
  //       String url="https://opp.ijmeet.com/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name??''}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //       // String url="https://testinterrog.opp.gov.om/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name??''}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //       // String url="https://interrog.opp.gov.om/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name??''}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //       Navigator.pop(context);
  //       if(Platform.isAndroid){
  //         Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) =>PublicWebViewScreen(url: url, name: widget.name??''))).then((value){
  //         });
  //       }else{
  //         launchUrl(Uri.parse(url),mode:LaunchMode.inAppWebView);
  //       }
  //     }else{
  //       // here is the code  400
  //       if(res!=null){
  //         WaitingResponseModel model=   WaitingResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(res!.bodyBytes)));
  //         isHost=((model.data?.code??'')=='host_waiting');
  //       }
  //     }
  //   }else{
  //     if(res!=null){
  //       WaitingResponseModel  model=   WaitingResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(res!.bodyBytes)));
  //       isHost=((model.data?.code??'')=='host_waiting');
  //       participantId=model.data?.participantId??'';
  //       if(participantId.isEmpty){
  //         res=await JitsiMeetService().joinMeeting(context:context,name:widget.name??'', meetignId:widget.meetingId??'',
  //             mobile:CacheHelper.getData(key:'mobile')??'', otp: CacheHelper.getData(key:'pin')??'');
  //       }
  //       Response response=await JitsiMeetService().getStatusParticipant(participantId: participantId,
  //           lang:context.locale.languageCode);
  //       if(response.statusCode==200||response.statusCode==201){
  //         if(timer!=null){timer!.cancel();}
  //         final data = jsonDecode(response.body);
  //         final meeting = data['data']['meeting'];
  //         final config = data['data']['config'];
  //         final meetingName = meeting['name'];
  //         final email = meeting['email'];
  //         final meetingId = meeting['m_id'];
  //         final conferenceUrl = data['data']['conference_url'];
  //         final participantId = meeting['participant_id'];
  //         bool startWithVideoMuted=config['startWithVideoMuted']=='no'?false:true;
  //         bool startWithAudioMuted=config['startWithAudioMuted']=='no'?false:true;
  //         dismissLoader();
  //         String url="https://opp.ijmeet.com/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //         // String url="https://testinterrog.opp.gov.om/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //         // String url="https://interrog.opp.gov.om/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //         Navigator.pop(context);
  //         if(Platform.isAndroid){
  //           Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) => PublicWebViewScreen(url: url, name: widget.name??''))).then((value){
  //           });
  //         }else{
  //           launchUrl(Uri.parse(url),mode:LaunchMode.inAppWebView);
  //         }
  //       }else{
  //         WaitingResponseModel  model=   WaitingResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));
  //         if((model.data?.code??'')=='reject_user'){
  //           if(timer!=null){timer!.cancel();}
  //           dismissLoader();
  //           Navigator.pop(context);
  //           ElegantNotification.error(title: Text(''),description: Text((model.msg??''))).show(context);
  //         }
  //       }
  //     }
  //   }
  // }

  // callJoinMeetingAfterHostTrue() async {
  //   res=await JitsiMeetService().joinMeeting(context:context,name:widget.name??'', meetignId:widget.meetingId??'',
  //       mobile:CacheHelper.getData(key:'mobile')??'', otp: CacheHelper.getData(key:'pin')??'');
  //   if(res!=null&&(res!.statusCode==200||res!.statusCode==201)){
  //     final data = jsonDecode(res!.body);
  //     final meeting = data['data']['meeting'];
  //     final config = data['data']['config'];
  //     final meetingName = meeting['name'];
  //     final meetingId = meeting['m_id'];
  //     final conferenceUrl = data['data']['conference_url'];
  //     final participantId = meeting['participant_id'];
  //     bool startWithVideoMuted=config['startWithVideoMuted']=='no'?false:true;
  //     bool startWithAudioMuted=config['startWithAudioMuted']=='no'?false:true;
  //     dismissLoader();
  //     String url="https://opp.ijmeet.com/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name??''}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //     // String url="https://testinterrog.opp.gov.om/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name??''}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //     // String url="https://interrog.opp.gov.om/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name??''}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //     Navigator.pop(context);
  //     if(Platform.isAndroid){
  //       Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) =>PublicWebViewScreen(url: url, name: widget.name??''))).then((value){
  //       });
  //     }else{
  //       launchUrl(Uri.parse(url),mode:LaunchMode.inAppWebView);
  //     }
  //   }else{
  //     // here is the code  400
  //     if(res!=null){
  //       WaitingResponseModel model=   WaitingResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(res!.bodyBytes)));
  //       isHost=((model.data?.code??'')=='host_waiting');
  //       if(isHost){
  //         callJoinMeetingAfterHostTrue();
  //       }else{
  //         callJoinMeetingAfterHostFalse();
  //       }
  //     }
  //   }
  // }
  //
  // callJoinMeetingAfterHostFalse() async {
  //     if(res!=null){
  //       WaitingResponseModel  model=   WaitingResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(res!.bodyBytes)));
  //       isHost=((model.data?.code??'')=='host_waiting');
  //       participantId=model.data?.participantId??'';
  //       if(participantId.isEmpty){
  //         res=await JitsiMeetService().joinMeeting(context:context,name:widget.name??'', meetignId:widget.meetingId??'',
  //             mobile:CacheHelper.getData(key:'mobile')??'', otp: CacheHelper.getData(key:'pin')??'');
  //       }
  //       Response response=await JitsiMeetService().getStatusParticipant(participantId: participantId,
  //           lang:context.locale.languageCode);
  //       if(response.statusCode==200||response.statusCode==201){
  //         // if(timer!=null){timer!.cancel();}
  //         final data = jsonDecode(response.body);
  //         final meeting = data['data']['meeting'];
  //         final config = data['data']['config'];
  //         final meetingName = meeting['name'];
  //         final email = meeting['email'];
  //         final meetingId = meeting['m_id'];
  //         final conferenceUrl = data['data']['conference_url'];
  //         final participantId = meeting['participant_id'];
  //         bool startWithVideoMuted=config['startWithVideoMuted']=='no'?false:true;
  //         bool startWithAudioMuted=config['startWithAudioMuted']=='no'?false:true;
  //         dismissLoader();
  //         String url="https://opp.ijmeet.com/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //         // String url="https://testinterrog.opp.gov.om/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //         // String url="https://interrog.opp.gov.om/conf?meeting_id=$meetingId&meeting_name=$meetingName&username=${widget.name}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=$conferenceUrl&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
  //         Navigator.pop(context);
  //         if(Platform.isAndroid){
  //           Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (_) => PublicWebViewScreen(url: url, name: widget.name??''))).then((value){
  //           });
  //         }else{
  //           launchUrl(Uri.parse(url),mode:LaunchMode.inAppWebView);
  //         }
  //       }else{
  //         WaitingResponseModel  model=   WaitingResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));
  //         if((model.data?.code??'')=='reject_user'){
  //           // if(timer!=null){timer!.cancel();}
  //           dismissLoader();
  //           Navigator.pop(context);
  //           ElegantNotification.error(title: Text(''),description: Text((model.msg??''))).show(context);
  //         }
  //       }
  //     }
  // }

  callMeetingDetail() async {
    if(mDetailTimer!=null){mDetailTimer!.cancel();}
    if(statusTimer!=null){statusTimer!.cancel();}
   WaitingResponseModel model= await JitsiMeetService().callMDetail(context:context,name:widget.name??'', meetignId:widget.meetingId??'',
        mobile:CacheHelper.getData(key:'mobile')??'', otp: CacheHelper.getData(key:'pin')??'');
   bool userStatus=(model.data?.code??'')=='accept_waiting'?true:false;
   participantId=model.data?.participantId??'';
   if(userStatus){
     // accept_waiting
    statusTimer= Timer.periodic(const Duration(seconds:5), (Timer t) => getStatus());
   }else{
    // host_waiting
     mDetailTimer= Timer.periodic(const Duration(seconds:5), (Timer t) => callMeetingDetail());
   }
  }

  getStatus() async {
    if(mDetailTimer!=null){mDetailTimer!.cancel();}
    if(statusTimer!=null){statusTimer!.cancel();}
    UserDataResponseModel model=await JitsiMeetService().getStatus(participantId: participantId,lang:context.locale.languageCode);
    if(model.success!=null&&model.success!){
      dismissLoader();
      bool startWithVideoMuted=model.data!.config!.startWithVideoMuted=='no'?false:true;
      bool startWithAudioMuted=model.data!.config!.startWithAudioMuted=='no'?false:true;
      // String url="https://opp.ijmeet.com/conf?meeting_id=${model.data?.meeting?.mId}&meeting_name=${model.data?.meeting?.name}&username=${widget.name}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=${model.data!.conferenceUrl}&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
      // String url="https://testinterrog.opp.gov.om/conf?meeting_id=${model.data?.meeting?.mId}&meeting_name=${model.data?.meeting?.name}&username=${widget.name}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=${model.data!.conferenceUrl}&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
      String url="https://interrog.opp.gov.om/conf?meeting_id=${model.data?.meeting?.mId}&meeting_name=${model.data?.meeting?.name}&username=${widget.name}&startWithVideoMuted=$startWithVideoMuted&startWithAudioMuted=$startWithAudioMuted&participant_id=$participantId&conference_url=${model.data!.conferenceUrl}&face_url=https%3A%2F%2Fopp.ijmeet.com%2Fstorage%2Fprofile%2F0BYlblDphyvldzqjQoi3lwfBZXQ8Tmg7js3nkGSZ.png";
      Navigator.pop(context);
      if(Platform.isAndroid){
        Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder:(_)=>PublicWebViewScreen(url: url, name: widget.name??'')));
      }else{
        launchUrl(Uri.parse(url),mode:LaunchMode.inAppWebView);
      }
    }else{
      if((model.data?.code??'')=='reject_user'){
        dismissLoader();
        Navigator.pop(context);
        ElegantNotification.error(title: Text(''),description: Text((model.msg??''))).show(context);
      }else{
        statusTimer= Timer.periodic(const Duration(seconds:5), (Timer t) => getStatus());
      }
    }
  }
}
