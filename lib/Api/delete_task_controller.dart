import 'package:apiinntrigation/Api/api_call.dart';

import 'package:apiinntrigation/Models/response_model.dart';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DeletedController extends GetxController {
  bool _isLoding = false;

  String _errorMessage = '';

  bool get isLoding => _isLoding;

  String get errorMessage => _errorMessage;

  Future<bool> delstedTask(String api) async {
    bool isSuccess = false;
    _isLoding = true;
    update();

    final NetworkResponse response = await ApiCall.getApiCall(api);
    // print(response.responseData);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Task Deleted';
    }

    _isLoding = false;
    update();

    return isSuccess;
  }
}
