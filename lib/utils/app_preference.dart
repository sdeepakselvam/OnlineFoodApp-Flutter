import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pedantic/pedantic.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base_app.dart';

class AppPreferences {
  AppPreferences._();

  static const _currentEnvironment = "current_environment";
  static const _loginStatus = "login_status";
  static const _userLanguage = "user_language";
  static const _token = "token";
  static const _phoneNumber = "phone_number";
  static const _countryCode = "country_code";

  static Future<void> setAuthenticationToken(String token) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    unawaited(localStorage.setString(_token, token));
  }

  static Future<String> getAuthenticationToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String token = localStorage.getString(_token);
    return token;
  }

  static Future<void> setLoginStatus(bool loginStatus) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    unawaited(localStorage.setBool(_loginStatus, loginStatus));
  }

  static Future<bool> getLoginStatus() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    bool loginStatus = localStorage.getBool(_loginStatus);
    return loginStatus ?? false;
  }

  static Future<String> getUserLanguage() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString(_userLanguage);
  }

  static Future<void> saveUserLanguage(String userLanguage) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    unawaited(localStorage.setString(_userLanguage, userLanguage));
  }

  static Future<void> logoutClearPreferences() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.remove(_loginStatus);
    await localStorage.remove(_token);

    await clearSecurelyStoredPreferences();
  }

  static Future<void> clearSecurelyStoredPreferences() async {
    final secureStorage = FlutterSecureStorage();
    await secureStorage.deleteAll();
  }

  static Future<void> setCurrentEnvironment(
      AppEnvironment currentEnvironment) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    unawaited(localStorage.setString(
        _currentEnvironment, EnumToString.parse(currentEnvironment)));
  }

  static Future<AppEnvironment> getCurrentEnvironment() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String currentEnvironmentString =
        localStorage.getString(_currentEnvironment);
    if (currentEnvironmentString != null &&
        currentEnvironmentString.isNotEmpty) {
      return EnumToString.fromString(
          AppEnvironment.values, currentEnvironmentString);
    }
    return null;
  }

  static Future<void> setPhoneNumber(value) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    unawaited(localStorage.setString(_phoneNumber, value));
  }

  static Future<String> getPhoneNumber() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString(_phoneNumber);
  }

  static Future<void> setCountryCode(value) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    unawaited(localStorage.setString(_countryCode, value));
  }

  static Future<String> getCountryCode() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString(_countryCode);
  }
}
