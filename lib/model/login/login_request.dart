class LoginRequestModel {
  String phoneNumber;
  String countryCode;

  LoginRequestModel({this.phoneNumber, this.countryCode});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['countryCode'] = this.countryCode;
    return data;
  }
}
