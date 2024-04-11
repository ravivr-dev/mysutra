class UserModel {
  String? message;
  UserData? data;
  int? totalUserAccounts;

  UserModel({this.message, this.data, this.totalUserAccounts});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
    totalUserAccounts = json['totalUserAccounts'];
  }
}

class UserData {
  String? id;
  String? role;
  String? profilePic;
  String? fullName;
  String? countryCode;
  int? phoneNumber;
  String? email;
  String? specializationId;
  String? specializationName;
  String? registrationNumber;
  List<String>? socialProfileUrls;
  String? dob;
  String? gender;
  String? location;
  bool? isVerified;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  String? token;

  UserData(
      {this.id,
      this.role,
      this.profilePic,
      this.fullName,
      this.countryCode,
      this.phoneNumber,
      this.email,
      this.specializationId,
      this.specializationName,
      this.registrationNumber,
      this.socialProfileUrls,
      this.dob,
      this.gender,
      this.location,
      this.isVerified,
      this.isBlocked,
      this.createdAt,
      this.updatedAt,
      this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    role = json['role'];
    profilePic = json['profilePic'];
    fullName = json['fullName'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    specializationId = json['specializationId'];
    specializationName = json['specializationName'];
    registrationNumber = json['specialization'];
    socialProfileUrls = json['socialProfileUrls'].cast<String>();
    dob = json['dob'];
    gender = json['gender'];
    location = json['location'];
    isVerified = json['isVerified'];
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    token = json['token'];
  }
}
