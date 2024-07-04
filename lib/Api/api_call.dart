import 'dart:convert';

import 'package:apiinntrigation/HelperMethod/auth_helper.dart';
import 'package:apiinntrigation/Models/response_model.dart';
import 'package:http/http.dart';

class ApiCall {
  static Future<NetworkResponse> getApiCall(String url) async {
    try {
      Response response =
          await get(Uri.parse(url), headers: {"token": AuthHelper.accessToken});
      if (response.statusCode == 200) {
        final resData = jsonDecode(response.body);
        print(resData);
        print("resData");
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: resData);
      } else if (response.statusCode == 401) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postApiCall(String url,
      {Map<String, dynamic>? body}) async {
    try {
      Response response = await post(Uri.parse(url),
          body: jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
            "token": AuthHelper.accessToken
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final resData = jsonDecode(response.body);
        print(resData['data']);
        print(resData);

        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: resData);
      } else if (response.statusCode == 401) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }
}
