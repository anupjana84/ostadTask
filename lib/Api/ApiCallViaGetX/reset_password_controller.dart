import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/Api/auth_controller_getx.dart';

import 'package:apiinntrigation/Api/index.dart';

import 'package:get/get.dart';
import 'package:apiinntrigation/Models/response_model.dart';

class ResetPasswordController extends GetxController {
  bool _isLoding = false;
  String _errorMessage = '';
  bool get isLoding => _isLoding;

  String get errorMessage => _errorMessage;

  Future<bool> submit(String password) async {
    final AuthControllerGetx authControllerGetx =
        Get.find<AuthControllerGetx>();
    _isLoding = true;
    bool inSuccess = false;
    update();
    final email = authControllerGetx.getEmail();
    final otp = authControllerGetx.getotp();

    Map<String, dynamic> requestDate = {
      "email": email,
      "otp": otp,
      "password": password
    };
    final NetworkResponse response =
        await ApiCall.postApiCall(Api.recoverResetPass, body: requestDate);
    print(response.responseData);
    if (response.isSuccess) {
      return inSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? "Somthing woring";
    }
    _isLoding = false;
    update();
    return inSuccess;
  }
}
