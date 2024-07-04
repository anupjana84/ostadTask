import 'dart:convert';

import 'package:apiinntrigation/Models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static String accessToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MjAxOTM0ODksImRhdGEiOiJyaXlAZ21haWwuY29tIiwiaWF0IjoxNzIwMTA3MDg5fQ.Ojwp2ekp4fjD6QP6PuvyVN6O7xjDwgqDrQZ6lzhsGbg";

  static UserModel? userData;

  static Future<void> userSave(UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("user-data", jsonEncode(user.toJson()));
  }

  static Future<UserModel?> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? data = sharedPreferences.getString("user-data");
    if (data == null) return null;

    UserModel userModel = UserModel.fromJson(jsonDecode(data));
    return userModel;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  static Future<void> tokenSave(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("token", token);
    accessToken = token;
  }

  static Future<String?> tokenGet() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("token");
  }

  static Future<bool> checkAuthState() async {
    String? token = await tokenGet();

    if (token == null) return false;

    accessToken = token;
    userData = await getUser();

    return true;
  }
}
