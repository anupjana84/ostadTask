import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/Api/auth_controller_getx.dart';

import 'package:get/get.dart';
import 'package:apiinntrigation/Models/response_model.dart';

class VerifyPinController extends GetxController {
  bool _isLoding = false;
  String _errorMessage = '';
  bool get isLoding => _isLoding;

  String get errorMessage => _errorMessage;

  Future<bool> submit(
    String url,
  ) async {
    _isLoding = true;
    bool inSuccess = false;
    update();

    final NetworkResponse response = await ApiCall.getApiCall(url);

    if (response.isSuccess) {
      // final s = response.responseData['data']['accepted'][0];
      // authControllerGetx.setEmail(s);

      return inSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? "wront otp";
    }
    _isLoding = false;
    update();
    return inSuccess;
  }
}
