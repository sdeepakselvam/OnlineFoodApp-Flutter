class LoginResponse {
  bool success;
  String timestamp;
  LoginData data;

  LoginResponse({this.success, this.timestamp, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    timestamp = json['timestamp'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
  }
}

class LoginData {
  String message;

  LoginData({this.message});

  LoginData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
