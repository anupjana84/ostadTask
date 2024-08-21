import 'package:get/get.dart';

class AuthControllerGetx extends GetxController {
  var accessToken = ''.obs;

  var email = ''.obs;
  var otp = ''.obs;

  String getToken() {
    return accessToken.value;
  }

  String getEmail() {
    return email.value;
  }

  String getotp() {
    return otp.value;
  }

  void setToken(String inputData) {
    accessToken.value = inputData; // Send data (set)
    // Fetch a simulated response
  }

  void setEmail(String inputData) {
    email.value = inputData; // Send data (set)
    // Fetch a simulated response
  }

  void setopt(String inputData) {
    otp.value = inputData; // Send data (set)
    // Fetch a simulated response
  }
}
