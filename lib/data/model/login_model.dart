
import 'package:tm_getx/data/models/user_model.dart';

class LoginModel {
  String? status;
  List<UserModel>? data;
  String? token;

  LoginModel({this.status, this.data, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    if (json['data'] != null) {
      if (json['data'] is List) {
        data = (json['data'] as List)
            .map((v) => UserModel.fromJson(v))
            .toList();
      } else if (json['data'] is Map<String, dynamic>) {
        data = [UserModel.fromJson(json['data'])];
      }
    }

    token = json['token'];
  }

}
