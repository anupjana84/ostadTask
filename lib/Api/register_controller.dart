import 'package:apiinntrigation/Api/api_call.dart';

import 'package:apiinntrigation/Api/index.dart';

import 'package:get/get.dart';
import 'package:apiinntrigation/Models/response_model.dart';

class RegisterController extends GetxController {
  bool _isLoding = false;
  String _errorMessage = '';
  bool get isLoding => _isLoding;

  String get errorMessage => _errorMessage;

  Future<bool> submit(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String password,
    String photo,
  ) async {
    _isLoding = true;
    bool inSuccess = false;
    update();
    Map<String, dynamic> requestDate = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": photo
    };
    final NetworkResponse response =
        await ApiCall.postApiCall(Api.register, body: requestDate);

    if (response.isSuccess) {
      return inSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? "register Fail Faild";
    }
    _isLoding = false;
    update();
    return inSuccess;
  }
}
