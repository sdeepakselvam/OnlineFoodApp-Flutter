import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_food_app/utils/app_configuration.dart';
import 'package:online_food_app/utils/app_preference.dart';
import 'package:online_food_app/webservice/network_check.dart';
import 'package:online_food_app/webservice/webservice_constants.dart';

typedef JSONResponseParser = dynamic Function(Map<String, dynamic> json);

class WebserviceHelper {
  static WebserviceHelper _instance = WebserviceHelper.internal();

  static const int WEB_SUCCESS_STATUS_CODE = 200;
  static const int ERROR_STATUS_CODE = 400;

  WebserviceHelper.internal();

  factory WebserviceHelper() => _instance;

  /// Get API call
  Future<Map<String, dynamic>> get({
    final String url,
    Map<String, String> headers,
    final dynamic Function(bool) onError,
  }) async {
    final bool isNetworkAvailable = await NetworkCheck().check();
    if (isNetworkAvailable) {
      final http.Response response = await http.get(Uri.parse(url),
          headers: headers ?? await addAuthenticationHeader());

      if (response != null) {
        Map<String, dynamic> jsonData;
        try {
          jsonData = jsonDecode(response.body) ?? {};
        } catch (e) {
          print(e.toString());
        }
        jsonData.putIfAbsent(
            WebserviceConstants.statusCode, () => response.statusCode);
        return jsonData;
      }
    }
    return onError != null ? onError(isNetworkAvailable) : null;
  }

  /// DELETE API call
  Future<Map<String, dynamic>> delete({
    final String url,
    Map<String, String> headers,
    final dynamic Function(bool) onError,
  }) async {
    if (AppConfiguration().isUserLoggedIn) {
      headers ??= {};
      headers = await addAuthenticationHeader();
    }

    final http.Response response = await http.delete(Uri.parse(url),
        headers: headers ?? await addAuthenticationHeader());
    if (response != null) {
      Map<String, dynamic> jsonData;
      try {
        jsonData = jsonDecode(response.body);
      } catch (_) {}
      jsonData ??= {};
      jsonData.putIfAbsent(
          WebserviceConstants.statusCode, () => response.statusCode);
      return jsonData;
    }

    return null;
  }

  // POST Api call
  Future<dynamic> post(
    String url, {
    Map<String, String> headers,
    Map<String, String> params,
    body,
  }) async {
    if (AppConfiguration().isUserLoggedIn) {
      headers ??= {};
      headers.addAll({
        WebserviceConstants.contentType: WebserviceConstants.applicationJson,
      });
    }
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    Map<String, dynamic> jsonData;
    try {
      jsonData = jsonDecode(response.body);
    } catch (_) {}
    if (jsonData == null) {
      jsonData = {};
    }
    jsonData.putIfAbsent(
        WebserviceConstants.statusCode, () => response.statusCode);

    return jsonData;
  }

  //PUT Api call
  Future<dynamic> put(
    String url, {
    Map<String, String> headers,
    Map<String, String> params,
    body,
  }) async {
    headers = await addAuthenticationHeader();
    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    Map<String, dynamic> jsonData;
    try {
      jsonData = jsonDecode(response.body);
    } catch (_) {}
    if (jsonData == null) {
      jsonData = {};
    }
    jsonData.putIfAbsent(
        WebserviceConstants.statusCode, () => response.statusCode);

    return jsonData;
  }

  Future<dynamic> patch(
    String url, {
    Map<String, String> headers,
    Map<String, String> params,
    body,
  }) async {
    headers = await addAuthenticationHeader();
    final response = await http.patch(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    Map<String, dynamic> jsonData;
    try {
      jsonData = jsonDecode(response.body);
    } catch (_) {}
    if (jsonData == null) {
      jsonData = {};
    }
    jsonData.putIfAbsent(
        WebserviceConstants.statusCode, () => response.statusCode);

    return jsonData;
  }
}

Future<Map<String, String>> addAuthenticationHeader() async {
  return {
    WebserviceConstants.authorization:
        await AppPreferences.getAuthenticationToken(),
    WebserviceConstants.contentType: WebserviceConstants.applicationJson
  };
}
