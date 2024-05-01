import 'package:my_sutra/core/utils/constants.dart';

class MyProfileResponseModel {
  final String message;
  final MyProfileModel data;

  MyProfileResponseModel({required this.message, required this.data});

  MyProfileResponseModel.fromJson(Map<String, dynamic> json)
      : message = json[Constants.message],
        data = MyProfileModel.fromJson(json[Constants.data]);
}

class MyProfileModel {
  final String? id;
  final String? profilePic;
  final String? fullName;
  final Specialization? specialization;
  final int? fees;
  final String role;
  final bool isVerified;
  final int? totalExperience;
  final int? totalFollowers;
  final String countryCode;
  final int? phoneNumber;
  final String? email;
  final String? about;
  final String? username;

  MyProfileModel.fromJson(Map<String, dynamic> json)
      : id = json[Constants.id],
        role = json[Constants.role],
        profilePic = json[Constants.profilePic],
        fullName = json[Constants.fullName],
        isVerified = json[Constants.isVerified],
        specialization = json[Constants.specialization] != null
            ? Specialization.fromJson(json[Constants.specialization])
            : null,
        totalExperience = json[Constants.totalExperience],
        totalFollowers = json[Constants.totalFollowers],
        countryCode = json[Constants.countryCode],
        phoneNumber = json[Constants.phoneNumber],
        email = json[Constants.email],
        fees = json[Constants.fees],
        about = json[Constants.about],
        username = json[Constants.userName];
}

class Specialization {
  String? id;
  String? name;

  Specialization({this.id, this.name});

  Specialization.fromJson(Map<String, dynamic> json)
      : id = json[Constants.id],
        name = json[Constants.name];
}
