import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/Api/index.dart';

import 'package:get/get.dart';
import 'package:apiinntrigation/Models/response_model.dart';

class NewtaskCreateController extends GetxController {
  bool _isLoding = false;
  String _errorMessage = '';
  bool get isLoding => _isLoding;

  String get errorMessage => _errorMessage;

  Future<bool> submit(String title, String description, String status) async {
    _isLoding = true;
    bool inSuccess = false;
    update();
    Map<String, dynamic> requestDate = {
      // "title": title,
      // "description": description,
      // "status": status
      "title": "My Task anup 2",
      "description": "My Task 2",
      "status": "New"
    };
    print(requestDate);
    final NetworkResponse response =
        await ApiCall.postApiCall(Api.newTasks, body: requestDate);
    print(response.statusCode);

    if (response.isSuccess) {
      return inSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? "New Task not Created";
    }
    _isLoding = false;
    update();
    return inSuccess;
  }
}
