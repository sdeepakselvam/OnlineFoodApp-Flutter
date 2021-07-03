class LoginOTPRequest {
  String phoneNumber;
  String countryCode;
  String otp;
  DeviceInfo deviceInfo;

  LoginOTPRequest(
      {this.phoneNumber, this.countryCode, this.otp, this.deviceInfo});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['countryCode'] = this.countryCode;
    data['otp'] = this.otp;
    if (this.deviceInfo != null) {
      data['deviceInfo'] = this.deviceInfo.toJson();
    }
    return data;
  }
}

class DeviceInfo {
  String deviceId;
  String osVersion;
  String appVersion;
  String platform;
  String ip;
  String pushToken;

  DeviceInfo(
      {this.deviceId,
      this.osVersion,
      this.appVersion,
      this.platform,
      this.ip,
      this.pushToken});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceId'] = this.deviceId;
    data['osVersion'] = this.osVersion;
    data['appVersion'] = this.appVersion;
    data['platform'] = this.platform;
    data['ip'] = this.ip;
    data['pushToken'] = this.pushToken;
    return data;
  }
}
