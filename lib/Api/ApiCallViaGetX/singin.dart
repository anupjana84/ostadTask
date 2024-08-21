import 'package:apiinntrigation/Api/api_call.dart';

import 'package:apiinntrigation/Api/index.dart';
import 'package:apiinntrigation/HelperMethod/auth_helper.dart';

import 'package:apiinntrigation/Models/auth_data.dart';
import 'package:get/get.dart';
import 'package:apiinntrigation/Models/response_model.dart';

class SignInController extends GetxController {
  bool _isLoding = false;
  String _errorMessage = '';
  bool get isLoding => _isLoding;

  String get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    _isLoding = true;
    bool inSuccess = false;
    update();
    Map<String, dynamic> requestDate = {"email": email, "password": password};
    final NetworkResponse response =
        await ApiCall.postApiCall(Api.login1, body: requestDate);

    if (response.isSuccess) {
      AuthModel authModel = AuthModel.fromJson(response.responseData);

      await AuthHelper.userSave(authModel.userModel!);
      await AuthHelper.tokenSave(authModel.token!);
      return inSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? "Login Faild";
    }
    _isLoding = false;
    update();
    return inSuccess;
  }
}
