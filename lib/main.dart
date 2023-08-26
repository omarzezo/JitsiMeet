import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
// import 'package:jitsi_meeting_plus/jitsi_meet_plus.dart';
import 'package:http/http.dart' as http;
import 'package:test_video_conference/cache_helper.dart';
import 'package:test_video_conference/constants.dart';
import 'package:test_video_conference/screens/home_screen.dart';
import 'package:test_video_conference/widgets/p_button.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  configLoading();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Meeting());
  }
}

class Meeting extends StatefulWidget {
  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  final  roomIdController = TextEditingController();
  final  nameController = TextEditingController();
  final  phoneController = TextEditingController();
  final  otpController = TextEditingController();
  // final roomText = TextEditingController(text: "plugintestroom");
  // final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  // final nameText = TextEditingController(text: "Plugin Test User");
  // final emailText = TextEditingController(text: "fake@email.com");
  // final iosAppBarRGBAColor =
  // TextEditingController(text: "#0080FF80"); //transparent blue
  // bool? isAudioOnly = true;
  // bool? isAudioMuted = true;
  // bool? isVideoMuted = true;
  // final roomText = TextEditingController(text: "jitsi-meet-wrapper-test-room");
  // final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  // final tokenText = TextEditingController();
  // // final userDisplayNameText = TextEditingController(text: "Plugin Test User");
  // final userEmailText = TextEditingController(text: "fake@email.com");
  // final userAvatarUrlText = TextEditingController();

  bool isAudioMuted = false;
  bool isAudioOnly = false;
  bool isVideoMuted = false;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:HomeScreen(),
      builder:EasyLoading.init(),
    );
  }

  // Widget buildMeetConfig() {
  //   return Column(mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,mainAxisSize: MainAxisSize.max,
  //     children: <Widget>[
  //       TextField(decoration: InputDecoration(
  //           filled: true,
  //           fillColor: Color(0xFFF2F2F2),
  //           focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(4)),
  //             borderSide: BorderSide(width: 1,color: Colors.red),
  //           ),
  //           disabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(4)),
  //             borderSide: BorderSide(width: 1,color: Colors.orange),
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(4)),
  //             borderSide: BorderSide(width: 1,color: Colors.green),
  //           ),
  //           border: OutlineInputBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(4)),
  //               borderSide: BorderSide(width: 1,)
  //           ),
  //           errorBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(4)),
  //               borderSide: BorderSide(width: 1,color: Colors.black)
  //           ),
  //           focusedErrorBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(4)),
  //               borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
  //           ),
  //           hintText: "Room Id",
  //           hintStyle: TextStyle(fontSize: 16,color: Color(0xFFB3B1B1)),
  //         ), controller:roomIdController,
  //       ),
  //       TextField(decoration: InputDecoration(
  //         filled: true,
  //         fillColor: Color(0xFFF2F2F2),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(4)),
  //           borderSide: BorderSide(width: 1,color: Colors.red),
  //         ),
  //         disabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(4)),
  //           borderSide: BorderSide(width: 1,color: Colors.orange),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(4)),
  //           borderSide: BorderSide(width: 1,color: Colors.green),
  //         ),
  //         border: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(4)),
  //             borderSide: BorderSide(width: 1,)
  //         ),
  //         errorBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(4)),
  //             borderSide: BorderSide(width: 1,color: Colors.black)
  //         ),
  //         focusedErrorBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(4)),
  //             borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
  //         ),
  //         hintText: "Name",
  //         hintStyle: TextStyle(fontSize: 16,color: Color(0xFFB3B1B1)),
  //       ), controller:nameController,
  //       ),
  //       TextField(decoration: InputDecoration(
  //         filled: true,
  //         fillColor: Color(0xFFF2F2F2),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(4)),
  //           borderSide: BorderSide(width: 1,color: Colors.red),
  //         ),
  //         disabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(4)),
  //           borderSide: BorderSide(width: 1,color: Colors.orange),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(4)),
  //           borderSide: BorderSide(width: 1,color: Colors.green),
  //         ),
  //         border: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(4)),
  //             borderSide: BorderSide(width: 1,)
  //         ),
  //         errorBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(4)),
  //             borderSide: BorderSide(width: 1,color: Colors.black)
  //         ),
  //         focusedErrorBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(4)),
  //             borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
  //         ),
  //         hintText: "Phone",
  //         hintStyle: TextStyle(fontSize: 16,color: Color(0xFFB3B1B1)),
  //       ), controller:phoneController,
  //       ),
  //       TextField(decoration: InputDecoration(
  //         filled: true,
  //         fillColor: Color(0xFFF2F2F2),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(4)),
  //           borderSide: BorderSide(width: 1,color: Colors.red),
  //         ),
  //         disabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(4)),
  //           borderSide: BorderSide(width: 1,color: Colors.orange),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(4)),
  //           borderSide: BorderSide(width: 1,color: Colors.green),
  //         ),
  //         border: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(4)),
  //             borderSide: BorderSide(width: 1,)
  //         ),
  //         errorBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(4)),
  //             borderSide: BorderSide(width: 1,color: Colors.black)
  //         ),
  //         focusedErrorBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(4)),
  //             borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
  //         ),
  //         hintText: "Otp",
  //         hintStyle: TextStyle(fontSize: 16,color: Color(0xFFB3B1B1)),
  //       ), controller:otpController,
  //       ),
  //       // const SizedBox(height: 200,),
  //       // // _buildTextField(labelText: "Room", controller: roomText),
  //       // const SizedBox(height: 16.0),
  //       // _buildTextField(labelText: "Subject", controller: subjectText),
  //       // const SizedBox(height: 16.0),
  //       // _buildTextField(labelText: "Token", controller: tokenText),
  //       // const SizedBox(height: 16.0),
  //       // _buildTextField(
  //       //   labelText: "User Display Name",
  //       //   controller: userDisplayNameText,
  //       // ),
  //       // const SizedBox(height: 16.0),
  //       // _buildTextField(
  //       //   labelText: "User Email",
  //       //   controller: userEmailText,
  //       // ),
  //       // const SizedBox(height: 16.0),
  //       // _buildTextField(
  //       //   labelText: "User Avatar URL",
  //       //   controller: userAvatarUrlText,
  //       // ),
  //       // const SizedBox(height: 16.0),
  //       // CheckboxListTile(
  //       //   title: const Text("Audio Muted"),
  //       //   value: isAudioMuted,
  //       //   onChanged: _onAudioMutedChanged,
  //       // ),
  //       // const SizedBox(height: 16.0),
  //       // CheckboxListTile(
  //       //   title: const Text("Audio Only"),
  //       //   value: isAudioOnly,
  //       //   onChanged: _onAudioOnlyChanged,
  //       // ),
  //       // const SizedBox(height: 16.0),
  //       // CheckboxListTile(
  //       //   title: const Text("Video Muted"),
  //       //   value: isVideoMuted,
  //       //   onChanged: _onVideoMutedChanged,
  //       // ),
  //       Center(
  //         child: SizedBox(
  //           height: 64.0,
  //           width: double.maxFinite,
  //           child: ElevatedButton(
  //             onPressed: () => _joinMeeting(),
  //             child: const Text(
  //               "Join Meeting",
  //               style: TextStyle(color: Colors.white),
  //             ),
  //             style: ButtonStyle(
  //               backgroundColor:
  //               MaterialStateColor.resolveWith((states) => Colors.blue),
  //             ),
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 48.0),
  //     ],
  //   );
  // }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value!;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value!;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value!;
    });
  }

  // _joinMeeting() async {
  //   if(roomIdController.text.isNotEmpty&&nameController.text.isNotEmpty&&
  //       phoneController.text.isNotEmpty&&otpController.text.isNotEmpty){
  //     // String roomText='53d5c60';
  //     // String roomText='db125fa';
  //     // String roomText='f58a18d';
  //     String roomText='c4fc911';
  //
  //     // API : https://interrog.opp.gov.om
  //     // Jitsi : https://ris.opp.gov.om
  //
  //     // String nameText='Test User';
  //     // String nameText='RIS_TST_LOF1';
  //     // String? apiUrl = Uri.encodeFull("https://ijmeet.com/api/mdetail/" + roomText + "?name=" + nameText);
  //
  //     // String? apiUrl = Uri.encodeFull("https://interrog.opp.gov.om/api/mdetail/" + roomText + "?name=" + nameText);
  //     // String? apiUrl = Uri.encodeFull("https://opp.ijmeet.com/api/mdetail/" + roomText + "?name=" + nameText+
  //     //     '&phone=71131936'+'&otp=1234');
  //     // print("apiUrl>>"+apiUrl.toString());
  //     // debugPrint("Start: $apiUrl");
  //     // final queryParameters = {'name':'Ahmed','phone': '71131936', 'otp': '1234',};
  //     final queryParameters = {'name':nameController.text,'phone': phoneController.text, 'otp': otpController.text};
  //
  //     // final uri = Uri.https('opp.ijmeet.com', '/api/mdetail/" + $roomText', queryParameters);
  //     // final uri = Uri.https('opp.ijmeet.com', '/api/mdetail/$roomText', queryParameters);
  //     final uri = Uri.https('interrog.opp.gov.om', '/api/mdetail/${roomIdController.text}', queryParameters);
  //     var response = await http.get(uri,headers:{'Content-Type': 'application/json', 'Accept': 'application/json'});
  //
  //     print("Url>>"+uri.scheme+'://'+uri.host+uri.path.toString());
  //     log("respIs>>"+response.body);
  //     // if (response.statusCode == 200||response.statusCode==201) {
  //     //   log("respIs>>"+response.body);
  //     // }
  //     final data = jsonDecode(response.body);
  //     final meeting = data['data']['meeting'];
  //     final config = data['data']['config'];
  //     final meetingName = meeting['name'];
  //     final email = meeting['email'];
  //     final meetingId = meeting['m_id'];
  //     final conferenceUrl = data['data']['conference_url'];
  //     final participantId = meeting['participant_id'];
  //     // String? serverUrl = "https://" + conferenceUrl + "/";
  //     String? serverUrl = 'https://worlditevents.com/';
  //     // String? serverUrl = 'https://ris.opp.gov.om/';
  //
  //     // Map valueMap = jsonDecode(config.toString());
  //     //   print("config>"+jsonEncode(config));
  //     print("conferenceUrl>>"+conferenceUrl.toString());
  //     Map<FeatureFlag, Object> featureFlags = {};
  //     if (Platform.isAndroid) {
  //       featureFlags[FeatureFlag.isCallIntegrationEnabled] = false;
  //     } else if (Platform.isIOS) {
  //       featureFlags[FeatureFlag.isPipEnabled] = false;
  //     }
  //
  //     var options = JitsiMeetingOptions(
  //       roomNameOrUrl:meetingId,
  //       serverUrl: serverUrl,
  //       subject: meetingName,
  //       token: '',configOverrides:jsonDecode(jsonEncode(config)),
  //       isAudioMuted: isAudioMuted,
  //       isAudioOnly: isAudioOnly,
  //       isVideoMuted: isVideoMuted,
  //       userDisplayName: nameController.text,
  //       // userEmail: 'Ahmed@ijtimaati.com',
  //       userEmail: email,
  //       featureFlags: featureFlags,
  //     );
  //
  //     debugPrint("JitsiMeetingOptions: $options");
  //     try{
  //       await JitsiMeetWrapper.joinMeeting(
  //         options: options,
  //         listener: JitsiMeetingListener(
  //           onOpened: () => debugPrint("onOpened"),
  //           onConferenceWillJoin: (url) {
  //             debugPrint("onConferenceWillJoin: url: $url");
  //           },
  //           onConferenceJoined: (url) {
  //             debugPrint("onConferenceJoined: url: $url");
  //           },
  //           onConferenceTerminated: (url, error) {
  //             debugPrint("onConferenceTerminated: url: $url, error: $error");
  //           },
  //           onAudioMutedChanged: (isMuted) {
  //             debugPrint("onAudioMutedChanged: isMuted: $isMuted");
  //           },
  //           onVideoMutedChanged: (isMuted) {
  //             debugPrint("onVideoMutedChanged: isMuted: $isMuted");
  //           },
  //           onScreenShareToggled: (participantId, isSharing) {
  //             debugPrint(
  //               "onScreenShareToggled: participantId: $participantId, "
  //                   "isSharing: $isSharing",
  //             );
  //           },
  //           onParticipantJoined: (email, name, role, participantId) {
  //             debugPrint(
  //               "onParticipantJoined: email: $email, name: $name, role: $role, "
  //                   "participantId: $participantId",
  //             );
  //           },
  //           onParticipantLeft: (participantId) {
  //             debugPrint("onParticipantLeft: participantId: $participantId");
  //           },
  //           onParticipantsInfoRetrieved: (participantsInfo, requestId) {
  //             debugPrint(
  //               "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
  //                   "requestId: $requestId",
  //             );
  //           },
  //           onChatMessageReceived: (senderId, message, isPrivate) {
  //             debugPrint(
  //               "onChatMessageReceived: senderId: $senderId, message: $message, "
  //                   "isPrivate: $isPrivate",
  //             );
  //           },
  //           onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
  //           onClosed: () => debugPrint("onClosed"),
  //         ),
  //       );
  //     }catch(e){
  //       print("errrr>>"+e.toString());
  //     }
  //   }else{
  //     Fluttertoast.showToast(
  //         msg: 'يرجي ملئ الفراغات',
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //     );
  //   }
  // }

  // _joinMeeting2() async {
  //   String? apiUrl = Uri.encodeFull("https://ijmeet.com/api/mdetail/" + roomText.text + "?name=" + nameText.text);
  //   debugPrint("Start: $apiUrl");
  //   var response = await http.get(Uri.parse(apiUrl));
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     final meeting = data['data']['meeting'];
  //     final meetingName = meeting['name'];
  //     final meetingId = meeting['m_id'];
  //     final conferenceUrl = data['data']['conference_url'];
  //     final participantId = meeting['participant_id'];
  //     String? serverUrl = "https://" + conferenceUrl + "/";
  //
  //
  //     var options = JitsiMeetingOptions(room: meetingId, roomNameOrUrl: '')
  //       ..serverURL = serverUrl
  //       ..subject = meetingName
  //       ..userDisplayName = nameText.text
  //       ..userEmail = "fake@email.com"
  //       ..iosAppBarRGBAColor = "#0080FF80"
  //       ..audioOnly = false
  //       ..audioMuted = false
  //       ..videoMuted = false
  //       ..featureFlags.addAll(featureFlags)
  //       ..webOptions = {
  //         "roomName": meetingId,
  //         "width": "100%",
  //         "height": "100%",
  //         "enableWelcomePage": false,
  //         "chromeExtensionBanner": null,
  //         "userInfo": {
  //           "displayName": nameText.text,
  //           "participantID": participantId,
  //           "baseURL": "https://ijmeet.com/"
  //         }
  //       };
  //     debugPrint("JitsiMeetingOptions: $options");
  //     await JitsiMeet.joinMeeting(
  //       options,
  //       listener: JitsiMeetingListener(
  //           onConferenceWillJoin: (message) {
  //             debugPrint("${options.room} will join with message: $message");
  //           },
  //           onConferenceJoined: (message) {
  //             debugPrint("${options.room} joined with message: $message");
  //           },
  //           onConferenceTerminated: (message) {
  //             debugPrint("${options.room} terminated with message: $message");
  //           },
  //           genericListeners: [
  //             JitsiGenericListener(
  //                 eventName: 'readyToClose',
  //                 callback: (dynamic message) {
  //                   debugPrint("readyToClose callback");
  //                 }),
  //           ]),
  //     );
  //   } else {
  //     String? statusc = response.statusCode.toString();
  //     debugPrint("Start: $statusc");
  //   }
  //   debugPrint("Start:End");
  // }



    Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
    String? hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText),
    );
  }

  // var doc_verify_url = "https://cv.ijmeet.com/"+room+"/"+participant_id+"/"+localStorage.getItem('language');
  // if(getFlagsData("doc_verify")){
  // doc_verify_url = getFlagsData("doc_verify")+"/"+room+"/"+participant_id+"/"+localStorage.getItem('language');
  // }

}


Future<void> configLoading() async {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 500)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 38.0
    ..radius = 0.0
    ..progressWidth=0.2
    ..progressColor = Constants.yellow
    ..backgroundColor = Colors.transparent
    ..boxShadow = <BoxShadow>[]
    ..maskType=EasyLoadingMaskType.clear
    ..indicatorColor = Constants.yellow
    ..textColor = Colors.white
    ..maskColor = Colors.grey[100]
    ..userInteractions = true
    ..dismissOnTap = false;
}