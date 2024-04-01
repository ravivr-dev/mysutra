import 'package:my_sutra/features/data/model/user_models/user_profile_model.dart';

class BatchStudentsModel {
  String? message;
  int? count;
  List<UserProfileData>? data;

  BatchStudentsModel({this.message, this.count, this.data});

  BatchStudentsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <UserProfileData>[];
      json['data'].forEach((v) {
        data!.add(UserProfileData.fromJson(v));
      });
    }
  }
}