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

  Data({this.participantId, this.code});

  Data.fromJson(Map<String, dynamic> json) {
    participantId = json['participant_id'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['participant_id'] = this.participantId;
    data['code'] = this.code;
    return data;
  }
}