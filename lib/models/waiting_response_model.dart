import 'package:test_video_conference/models/user_data_response_model.dart';

class WaitingResponseModel {
  bool? success;
  Data? data;
  String? msg;

  WaitingResponseModel({this.success, this.data, this.msg});

  WaitingResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Data {
  String? participantId;
  String? code;
  Meeting? meeting;
  String? conferenceUrl;
  Config? config;

  Data({this.participantId, this.code,this.meeting, this.conferenceUrl, this.config});

  Data.fromJson(Map<String, dynamic> json) {
    participantId = json['participant_id'];
    code = json['code'];
    meeting =
    json['meeting'] != null ? new Meeting.fromJson(json['meeting']) : null;
    conferenceUrl = json['conference_url'];
    config =
    json['config'] != null ? new Config.fromJson(json['config']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['participant_id'] = this.participantId;
    data['code'] = this.code;
    if (this.meeting != null) {
      data['meeting'] = this.meeting!.toJson();
    }
    data['conference_url'] = this.conferenceUrl;
    if (this.config != null) {
      data['config'] = this.config!.toJson();
    }
    return data;
  }
}