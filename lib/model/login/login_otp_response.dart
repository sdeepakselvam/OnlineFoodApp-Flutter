class LoginOTPResponse {
  bool success;
  String timestamp;
  Data data;

  LoginOTPResponse({this.success, this.timestamp, this.data});

  LoginOTPResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    timestamp = json['timestamp'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String authToken;
  String refreshToken;
  User user;
  bool isNewUser;

  Data({this.authToken, this.refreshToken, this.user, this.isNewUser});

  Data.fromJson(Map<String, dynamic> json) {
    authToken = json['authToken'];
    refreshToken = json['refreshToken'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    isNewUser = json['isNewUser'];
  }
}

class User {
  int id;
  String countryCode;
  String phoneNumber;

  User({this.id, this.countryCode, this.phoneNumber});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
  }
}
