import 'package:my_sutra/features/data/model/user_models/otp_model.dart';

class UserAccountsModel {
  String? message;
  List<UserData>? data;

  UserAccountsModel({this.message, this.data});

  UserAccountsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data!.add(UserData.fromJson(v));
      });
    }
  }
}
