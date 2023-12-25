class MobileMeetingResponseModel {
  bool? success;
  String? msg;
  Data? data;

  MobileMeetingResponseModel({this.success, this.msg, this.data});

  MobileMeetingResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? mid;
  String? phone;
  String? pid;

  Data({this.mid, this.phone, this.pid});

  Data.fromJson(Map<String, dynamic> json) {
    mid = json['mid'];
    phone = json['phone'];
    pid = json['pid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mid'] = this.mid;
    data['phone'] = this.phone;
    data['pid'] = this.pid;
    return data;
  }
}