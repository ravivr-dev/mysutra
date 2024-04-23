import '../../../data/model/user_models/my_profile_model.dart';

class MyProfileEntity {
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
  String? about;

  MyProfileEntity({
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

  set setAbout(String about) {
    this.about = about;
  }
}
