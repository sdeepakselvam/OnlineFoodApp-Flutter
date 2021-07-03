import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:online_food_app/utils/app_configuration.dart';
import 'package:online_food_app/utils/app_preference.dart';

import 'network_check.dart';
import 'webservice_constants.dart';

typedef JSONResponseParser = dynamic Function(Map<String, dynamic> json);

class WebserviceHelper {
  // next three lines makes this class a Singleton
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
      print("header " + headers.toString());
      final http.Response response = await http.get(url,
          headers: headers);

      if (response != null) {
        Map<String, dynamic> jsonData;
        try {
          jsonData = jsonDecode(response.body)??{};
          print(response.body);
        } catch (e) {
          print(e.toString());
        }
        jsonData.putIfAbsent(
            WebserviceConstants.statusCode, () => response.statusCode);
        print(jsonData);
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
    print(url);
    print(body);
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    Map<String, dynamic> jsonData;
    print(response.body);
    try {
      jsonData = jsonDecode(response.body);
      print("response " + jsonData.toString());
    } catch (_) {}
    if (jsonData == null) {
      jsonData = {};
    }
    jsonData.putIfAbsent(
        WebserviceConstants.statusCode, () => response.statusCode);

    return jsonData;
  }

  Future<dynamic> put(
      String url, {
        Map<String, String> headers,
        Map<String, String> params,
        body,
      }) async {
    if (AppConfiguration().isUserLoggedIn) {
      headers = await addAuthenticationHeader();
    }
    print("body " + body.toString());

    final response = await http.put(
      url,
      headers: headers,
      body: body,
    );
    Map<String, dynamic> jsonData;
    try {
      jsonData = jsonDecode(response.body);
      print("response " + jsonData.toString());
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
    if (AppConfiguration().isUserLoggedIn) {
      Map<String, String> authHeaders = await addAuthenticationHeader();
      if (headers != null) {
        headers.addAll(authHeaders);
      } else {
        headers = authHeaders;
      }
    }

    print(headers);
    print(body);
    final response = await http.patch(
      url,
      headers: headers,
      body: body,
    );

    Map<String, dynamic> jsonData;
    try {
      jsonData = jsonDecode(response.body);
      print("response " + jsonData.toString());
    } catch (_) {}
    if (jsonData == null) {
      jsonData = {};
    }
    jsonData.putIfAbsent(
        WebserviceConstants.statusCode, () => response.statusCode);

    return jsonData;
  }

  Future<dynamic> delete(
      String url, {
        Map<String, String> headers,
        Map<String, String> params,
      }) async {
    if (AppConfiguration().isUserLoggedIn) {
      Map<String, String> authHeaders = await addAuthenticationHeader();
      if (headers != null) {
        headers.addAll(authHeaders);
      } else {
        headers = authHeaders;
      }
    }

    final response = await http.delete(
      url,
      headers: headers ?? {},
    );
    Map<String, dynamic> jsonData;
    try {
      jsonData = jsonDecode(response.body);
      print("response " + jsonData.toString());
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
      await AppPreferences.getAuthenticationToken()
    };
  }

}
