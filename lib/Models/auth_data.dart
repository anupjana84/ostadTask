import 'package:apiinntrigation/Models/user_data.dart';

class AuthModel {
  String? status;
  String? token;
  UserModel? userModel;

  AuthModel({this.status, this.token, this.userModel});

  AuthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    userModel = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    if (userModel != null) {
      data['data'] = userModel!.toJson();
    }
    return data;
  }
}
