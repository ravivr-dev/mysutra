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

  MyProfileModel({
    required this.id,
    required this.profilePic,
    required this.fullName,
    required this.specialization,
    required this.fees,
    required this.role,
    required this.isVerified,
    required this.totalExperience,
    required this.totalFollowers,
    required this.countryCode,
    required this.phoneNumber,
    required this.email,
    required this.about,
  });

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
        about = json[Constants.about];
}

class Specialization {
  String? id;
  String? name;

  Specialization({this.id, this.name});

  Specialization.fromJson(Map<String, dynamic> json)
      : id = json[Constants.id],
        name = json[Constants.user];
}
