import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:online_food_app/api_utils/api_config.dart';
import 'package:online_food_app/model/login/login_otp_request.dart';
import 'package:online_food_app/model/login/login_otp_response.dart';
import 'package:online_food_app/model/login/login_request.dart';
import 'package:online_food_app/model/login/login_response.dart';
import 'package:online_food_app/utils/app_constants.dart';
import 'package:online_food_app/utils/app_preference.dart';
import 'package:online_food_app/webservice/webservice_constants.dart';
import 'package:online_food_app/webservice/webservice_helper.dart';
import 'package:online_food_app/widget/custom_progress_circle.dart';

class UserProfileRepository {
  WebserviceHelper _webserviceHelper = WebserviceHelper();

  Future<LoginResponse> postSentOTP(
      BuildContext context, LoginRequestModel loginRequestModel) async {
    ProgressCircle _circle = ProgressCircle(context);
    _circle.showProgressBar();
    String finalUrl = ApiConfig.baseUrl + ApiConfig.sentOTP;
    Map<String, String> headers = {
      WebserviceConstants.contentType: WebserviceConstants.applicationJson
    };
    String json = jsonEncode(loginRequestModel.toJson());

    Map<String, dynamic> result =
        await _webserviceHelper.post(finalUrl, body: json, headers: headers);

    _circle.hideProgressBar();
    if (result[WebserviceConstants.statusCode] ==
        WebserviceHelper.WEB_SUCCESS_STATUS_CODE) {
      return LoginResponse.fromJson(result);
    } else {
      return null;
    }
  }

  Future<LoginOTPResponse> postSignInApi(
      BuildContext context, LoginOTPRequest loginOTPRequest) async {
    ProgressCircle _circle = ProgressCircle(context);
    _circle.showProgressBar(text: "Loading");
    String finalUrl = ApiConfig.baseUrl + ApiConfig.login;
    Map<String, String> headers = {
      WebserviceConstants.contentType: WebserviceConstants.applicationJson,
    };
    String json = jsonEncode(loginOTPRequest.toJson());

    Map<String, dynamic> result =
        await _webserviceHelper.post(finalUrl, body: json, headers: headers);

    _circle.hideProgressBar();
    LoginOTPResponse response = LoginOTPResponse.fromJson(result);
    if (response.statusCode == WebserviceHelper.WEB_SUCCESS_STATUS_CODE) {
      await AppPreferences.setAuthenticationToken(response.data.authToken);
      await AppPreferences.setLoginStatus(true);
      return LoginOTPResponse.fromJson(result);
    } else {
      return null;
    }
  }

  Future<bool> signOut(BuildContext context) async {
    String finalUrl = ApiConfig.baseUrl + ApiConfig.login;
    ProgressCircle _circle = ProgressCircle(context);
    _circle.showProgressBar(text: AppConstants.signingOff);

    Map<String, dynamic> result = await _webserviceHelper.delete(finalUrl);

    _circle.hideProgressBar();
    if (result[WebserviceConstants.statusCode] ==
        WebserviceHelper.WEB_SUCCESS_STATUS_CODE) {
      return true;
    } else {
      return false;
    }
  }
}
