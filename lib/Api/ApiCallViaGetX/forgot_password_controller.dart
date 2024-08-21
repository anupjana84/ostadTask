import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/Api/auth_controller_getx.dart';

import 'package:get/get.dart';
import 'package:apiinntrigation/Models/response_model.dart';

class ForgotPasswordController extends GetxController {
  bool _isLoding = false;
  String _errorMessage = '';
  bool get isLoding => _isLoding;

  String get errorMessage => _errorMessage;

  Future<bool> submit(
    String url,
  ) async {
    final AuthControllerGetx authControllerGetx =
        Get.find<AuthControllerGetx>();
    _isLoding = true;
    bool inSuccess = false;
    update();

    final NetworkResponse response = await ApiCall.getApiCall(url);

    if (response.isSuccess) {
      // print(response.responseData['data']['accepted'][0]);
      authControllerGetx
          .setEmail(response.responseData['data']['accepted'][0].toString());
      return inSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? "New Task not Created";
    }
    _isLoding = false;
    update();
    return inSuccess;
  }
}
