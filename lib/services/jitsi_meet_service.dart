import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:test_video_conference/common_methods.dart';
import 'package:test_video_conference/models/face_token_response.dart';
import 'package:test_video_conference/models/user_data_response_model.dart';
import 'package:test_video_conference/models/waiting_response_model.dart';
import 'package:url_launcher/url_launcher.dart';


class JitsiMeetService {
  final baseURL ='https://interrog.opp.gov.om/api';
  // final baseURL ='https://opp.ijmeet.com/api';
  // final baseURL ='https://testinterrog.opp.gov.om/api';

  Future<http.Response> sendMobileNumber({required String mobile,required String lang}) async {
    showLoader();
    print("urlIs>>"+"${baseURL}/send-otp/$mobile");
    var response = await http.get(Uri.parse("${baseURL}/send-otp/$mobile"),
        headers: {'Content-Type': 'application/json','Accept': 'application/json','lang':lang});
    print("responseIS>>"+response.body);
    dismissLoader();
    return response;
  }

  Future<http.Response> sendOTP({required String mobile,required String otp,required String lang}) async {
    showLoader();
    print("urlIs>>"+"${baseURL}/verify-otp/$mobile/$otp");
    var response = await http.get(Uri.parse("${baseURL}/verify-otp/$mobile/$otp"),
        headers: {'Content-Type': 'application/json','Accept': 'application/json','lang':lang});
    print(response.body);
    dismissLoader();
    return response;
  }

  Future<http.Response> joinMeeting({required BuildContext context,required String name,required String meetignId,
    required String mobile,required String otp}) async {
    showLoader();
      final queryParameters = {'name':name,'phone':mobile, 'otp':otp,'lang':context.locale.languageCode};
      final uri = Uri.https('interrog.opp.gov.om', '/api/mdetail/${meetignId}', queryParameters);
      // final uri = Uri.https('opp.ijmeet.com', '/api/mdetail/${meetignId}', queryParameters);
      // final uri = Uri.https('testinterrog.opp.gov.om', '/api/mdetail/${meetignId}', queryParameters);
      var response = await http.get(uri,headers:{'Content-Type': 'application/json', 'Accept': 'application/json'});
      log("Urlkkkkk>>"+uri.scheme+'://'+uri.host+uri.path.toString());
      log("datatat>>"+uri.queryParameters.toString());
      log("respIssss>>"+response.body);
      try{
      }catch(e){
        print("errrr>>"+e.toString());
      }
      return response;
  }


  Future<WaitingResponseModel> callMDetail({required BuildContext context,required String name,required String meetignId,
    required String mobile,required String otp}) async {
    showLoader();
    final queryParameters = {'name':name,'phone':mobile, 'otp':otp,'lang':context.locale.languageCode};
    final uri = Uri.https('interrog.opp.gov.om', '/api/mdetail/${meetignId}', queryParameters);
    // final uri = Uri.https('opp.ijmeet.com', '/api/mdetail/${meetignId}', queryParameters);
    // final uri = Uri.https('testinterrog.opp.gov.om', '/api/mdetail/${meetignId}', queryParameters);
    var response = await http.get(uri,headers:{'Content-Type': 'application/json', 'Accept': 'application/json'});
    log("Urlkkkkk>>"+uri.scheme+'://'+uri.host+uri.path.toString());
    log("datatat>>"+uri.queryParameters.toString());
    log("respIssss>>"+response.body);
    WaitingResponseModel model=   WaitingResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));
    return model;
  }

  Future<UserDataResponseModel> getStatus({required String participantId,required String lang}) async {
    showLoader();
    print("urlIs>>"+"${baseURL}/get_status/$participantId");
    var response = await http.get(Uri.parse("${baseURL}/get_status/$participantId"),
        headers: {'Content-Type': 'application/json','Accept': 'application/json','lang':lang});
    print("responseIS>>"+response.body);
    dismissLoader();
    UserDataResponseModel model=   UserDataResponseModel.fromJson(jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));
    return model;
  }

  Future<http.Response> getStatusParticipant({required String participantId,required String lang}) async {
    showLoader();
    print("urlIs>>"+"${baseURL}/get_status/$participantId");
    var response = await http.get(Uri.parse("${baseURL}/get_status/$participantId"),
        headers: {'Content-Type': 'application/json','Accept': 'application/json','lang':lang});
    print("responseIS>>"+response.body);
    dismissLoader();
    return response;
  }

  // Future<FaceTokenResponse> getFaceToken ()async {
  //   // var response = await http.post(Uri.parse("https://auth.uqudo.io/api/oauth/token"),
  //   var response = await http.post(Uri.parse("https://auth.dev.uqudo.io/api/oauth/token?grant_type=client_credentials&client_id=5b41841f-0c82-4af9-a9d0-a52ec938bf24&client_secret=lNQp0yy092O615ssrtqYZQl5"),
  //   // var response = await http.post(Uri.parse("https://auth.uqudo.io/api/oauth/token?grant_type=client_credentials&client_id=5b41841f-0c82-4af9-a9d0-a52ec938bf24&client_secret=lNQp0yy092O615ssrtqYZQl5"),
  //       headers: {'Content-Type': 'application/json', 'Accept': 'application/json',
  //         },body: jsonEncode({'grant_type' :'client_credentials',  'client_id':'5b41841f-0c82-4af9-a9d0-a52ec938bf24',
  //         'client_secret':'lNQp0yy092O615ssrtqYZQl5'}));
  //   print("object>>"+response.body);
  //   FaceTokenResponse model = (jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));
  //   print("object>>"+jsonEncode(model));
  //   return model;
  // }

}