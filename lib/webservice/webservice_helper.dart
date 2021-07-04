import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_food_app/utils/app_preference.dart';
import 'network_check.dart';
import 'webservice_constants.dart';

typedef JSONResponseParser = dynamic Function(Map<String, dynamic> json);

class WebserviceHelper {
  static WebserviceHelper _instance = WebserviceHelper.internal();

  static const int WEB_SUCCESS_STATUS_CODE = 200;
  static const int ERROR_STATUS_CODE = 401;

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
      final http.Response response = await http.get(url, headers: headers);

      if (response != null) {
        Map<String, dynamic> jsonData;
        try {
          jsonData = jsonDecode(response.body) ?? {};
        } catch (e) {}
        jsonData.putIfAbsent(
            WebserviceConstants.statusCode, () => response.statusCode);
        return jsonData;
      }
    }
    return onError != null ? onError(isNetworkAvailable) : null;
  }

  /// Post API call
  Future<dynamic> post(
    String url, {
    Map<String, String> headers,
    Map<String, String> params,
    body,
  }) async {
    final response = await http.post(
      url,
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

  //Delete API call
  Future<dynamic> delete(
    String url, {
    Map<String, String> headers,
    Map<String, String> params,
  }) async {
    Map<String, String> authHeaders = await addAuthenticationHeader();
    if (headers != null) {
      headers.addAll(authHeaders);
    } else {
      headers = authHeaders;
    }

    final response = await http.delete(
      url,
      headers: headers ?? {},
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

  Future<Map<String, String>> addAuthenticationHeader() async {
    return {
      WebserviceConstants.authorization:
          await AppPreferences.getAuthenticationToken(),
      WebserviceConstants.contentType: WebserviceConstants.applicationJson
    };
  }
}
