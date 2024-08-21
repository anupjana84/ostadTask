import 'package:apiinntrigation/Api/ApiCallViaGetX/forgot_password_controller.dart';
import 'package:apiinntrigation/Api/ApiCallViaGetX/new_task_list_controller.dart';
import 'package:apiinntrigation/Api/ApiCallViaGetX/newtask_create_controller.dart';
import 'package:apiinntrigation/Api/ApiCallViaGetX/reset_password_controller.dart';
import 'package:apiinntrigation/Api/ApiCallViaGetX/singin.dart';
import 'package:apiinntrigation/Api/ApiCallViaGetX/verify_pin_controller.dart';
import 'package:apiinntrigation/Api/auth_controller_getx.dart';
import 'package:apiinntrigation/Api/delete_task_controller.dart';
import 'package:apiinntrigation/Api/update_task_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => SignInController());
    // Get.lazyPut(() => NewtaskCreateController());
    // Get.lazyPut(() => NewTaskController());
    // Get.lazyPut(() => AuthControllerGetx());
    Get.put(SignInController());
    Get.put(NewtaskCreateController());
    Get.put(NewTaskController());
    Get.put(AuthControllerGetx());
    Get.put(DeletedController());
    Get.put(UpdateTaskController());
    Get.put(ForgotPasswordController());
    Get.put(VerifyPinController());
    Get.put(ResetPasswordController());
  }
}
