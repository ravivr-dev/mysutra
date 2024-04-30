import 'package:my_sutra/core/utils/constants.dart';

class HomeResponseModel {
  final String message;
  final UserModel userModel;

  HomeResponseModel.fromJson(Map<String, dynamic> json)
      : message = json[Constants.message],
        userModel = UserModel.fromJson(json[Constants.data]);
}

///Everything would be null (except role) in case of GUEST user
class UserModel {
  final String? fullName;
  final String? username;
  final String? profilePic;
  final bool? isVerified;
  final String role;
  final String? gender;
  final String? age;

  UserModel.fromJson(Map<String, dynamic> json)
      : fullName = json[Constants.fullName],
        username = json[Constants.userName],
        profilePic = json[Constants.profilePic],
        isVerified = json[Constants.isVerified],
        role = json[Constants.role],
        gender = json[Constants.gender],
        age = json[Constants.age];
}
