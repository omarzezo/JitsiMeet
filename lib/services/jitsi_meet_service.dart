import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:test_video_conference/common_methods.dart';


class JitsiMeetService {
  final baseURL ='https://interrog.opp.gov.om/api';
  // final baseURL ='https://opp.ijmeet.com/api';

  Future<http.Response> sendMobileNumber({required String mobile}) async {
    showLoader();
    print("urlIs>>"+"${baseURL}/send-otp/$mobile");
    var response = await http.get(Uri.parse("${baseURL}/send-otp/$mobile"),
        headers: {'Content-Type': 'application/json','Accept': 'application/json',});
    print("responseIS>>"+response.body);
    dismissLoader();
    return response;
  }

  Future<http.Response> sendOTP({required String mobile,required String otp}) async {
    showLoader();
    print("urlIs>>"+"${baseURL}/verify-otp/$mobile/$otp");
    var response = await http.get(Uri.parse("${baseURL}/verify-otp/$mobile/$otp"),
        headers: {'Content-Type': 'application/json','Accept': 'application/json',});
    print(response.body);
    dismissLoader();
    return response;
  }

  Future<void> joinMeeting({required String name,required String meetignId,
    required String mobile,required String otp}) async {
      final queryParameters = {'name':name,'phone':mobile, 'otp':otp};
      final uri = Uri.https('interrog.opp.gov.om', '/api/mdetail/${meetignId}', queryParameters);
      // final uri = Uri.https('opp.ijmeet.com', '/api/mdetail/${meetignId}', queryParameters);
      var response = await http.get(uri,headers:{'Content-Type': 'application/json', 'Accept': 'application/json'});
      print("Url>>"+uri.scheme+'://'+uri.host+uri.path.toString());
      log("respIs>>"+response.body);
      final data = jsonDecode(response.body);
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
      // Map valueMap = jsonDecode(config.toString());
      //   print("config>"+jsonEncode(config));
      print("conferenceUrl>>"+conferenceUrl.toString());
      Map<FeatureFlag, Object> featureFlags = {};
      if (Platform.isAndroid) {
        featureFlags[FeatureFlag.isCallIntegrationEnabled] = false;
      } else if (Platform.isIOS) {
        featureFlags[FeatureFlag.isPipEnabled] = false;
      }

      var options = JitsiMeetingOptions(
        roomNameOrUrl:meetingId,
        serverUrl: serverUrl,
        subject: meetingName,
        token: '',configOverrides:jsonDecode(jsonEncode(config)),
        isAudioMuted: false,
        isAudioOnly: false,
        isVideoMuted: false,
        userDisplayName:name,
        // userEmail: 'Ahmed@ijtimaati.com',
        userEmail: email,
        featureFlags: featureFlags,
      );
      debugPrint("JitsiMeetingOptions: $options");
      try{
        await JitsiMeetWrapper.joinMeeting(
          options: options,
          listener: JitsiMeetingListener(
            onOpened: () => debugPrint("onOpened"),
            onConferenceWillJoin: (url) {
              debugPrint("onConferenceWillJoin: url: $url");
            },
            onConferenceJoined: (url) {
              debugPrint("onConferenceJoined: url: $url");
            },
            onConferenceTerminated: (url, error) {
              debugPrint("onConferenceTerminated: url: $url, error: $error");
            },
            onAudioMutedChanged: (isMuted) {
              debugPrint("onAudioMutedChanged: isMuted: $isMuted");
            },
            onVideoMutedChanged: (isMuted) {
              debugPrint("onVideoMutedChanged: isMuted: $isMuted");
            },
            onScreenShareToggled: (participantId, isSharing) {
              debugPrint(
                "onScreenShareToggled: participantId: $participantId, "
                    "isSharing: $isSharing",
              );
            },
            onParticipantJoined: (email, name, role, participantId) {
              debugPrint(
                "onParticipantJoined: email: $email, name: $name, role: $role, "
                    "participantId: $participantId",
              );
            },
            onParticipantLeft: (participantId) {
              debugPrint("onParticipantLeft: participantId: $participantId");
            },
            onParticipantsInfoRetrieved: (participantsInfo, requestId) {
              debugPrint(
                "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
                    "requestId: $requestId",
              );
            },
            onChatMessageReceived: (senderId, message, isPrivate) {
              debugPrint(
                "onChatMessageReceived: senderId: $senderId, message: $message, "
                    "isPrivate: $isPrivate",
              );
            },
            onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
            onClosed: () => debugPrint("onClosed"),
          ),
        );
      }catch(e){
        print("errrr>>"+e.toString());
      }
  }
}