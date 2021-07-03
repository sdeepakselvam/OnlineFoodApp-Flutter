import 'package:flutter/material.dart';
import 'package:online_food_app/api_utils/api_config.dart';
import 'package:online_food_app/model/product/product_list_response.dart';
import 'package:online_food_app/utils/app_constants.dart';
import 'package:online_food_app/utils/app_preference.dart';
import 'package:online_food_app/webservice/webservice_constants.dart';
import 'package:online_food_app/webservice/webservice_helper.dart';
import 'package:online_food_app/widget/custom_progress_circle.dart';

class ProductRepository {
  WebserviceHelper _webserviceHelper = WebserviceHelper();

  Future<ProductListResponse> getProductList(BuildContext context,
      {String latitude, String longitude}) async {
    ProgressCircle _circle = ProgressCircle(context);
    _circle.showProgressBar(text: AppConstants.fetchingFoodItems);
    String finalUrl = ApiConfig.baseUrl +
        ApiConfig.productList
            .replaceAll("\$latitude", latitude)
            .replaceAll("\$longitude", longitude);
    String token = await AppPreferences.getAuthenticationToken();
    Map<String, String> headers = {
      WebserviceConstants.authorization: token,
      WebserviceConstants.contentType: WebserviceConstants.applicationJson,
    };

    Map<String, dynamic> result =
        await _webserviceHelper.get(url: finalUrl, headers: headers);

    _circle.hideProgressBar();
    if (result[WebserviceConstants.statusCode] ==
        WebserviceHelper.WEB_SUCCESS_STATUS_CODE) {
      return ProductListResponse.fromJson(result);
    } else {
      return null;
    }
  }
}
