import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/Api/index.dart';
import 'package:apiinntrigation/Models/new_task_wraper.dart';
import 'package:apiinntrigation/Models/response_model.dart';
import 'package:apiinntrigation/Models/task_item.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NewTaskController extends GetxController {
  bool _isLoding = false;
  List<TaskItemModel> _newTaskList = [];
  String _errorMessage = '';

  bool get isLoding => _isLoding;

  List<TaskItemModel> get newTaskList => _newTaskList;

  String get errorMessage => _errorMessage;

  Future<bool> getdata(url) async {
    bool isSuccess = false;
    _isLoding = true;
    update();

    final NetworkResponse response = await ApiCall.getApiCall(url);
    // print(response.responseData);
    if (response.isSuccess) {
      NewTaskWraper newTaskWraper =
          NewTaskWraper.fromJson(response.responseData);
      _newTaskList = newTaskWraper.newTasWraperkList ?? [];

      isSuccess = true;
    } else {
      _errorMessage =
          response.errorMessage ?? 'Get Notification failed! Try again';
    }

    _isLoding = false;
    update();

    return isSuccess;
  }
}
