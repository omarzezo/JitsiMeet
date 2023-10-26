class FaceTokenResponse {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? jti;

  FaceTokenResponse(
      {this.accessToken, this.tokenType, this.expiresIn, this.jti});

  FaceTokenResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    tokenType = json['tokenType'];
    expiresIn = json['expiresIn'];
    jti = json['jti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['tokenType'] = this.tokenType;
    data['expiresIn'] = this.expiresIn;
    data['jti'] = this.jti;
    return data;
  }
}