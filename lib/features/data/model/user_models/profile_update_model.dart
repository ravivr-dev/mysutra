class ProfileUpdateModel {
  String? message;
  ProfileUpdateData? data;

  ProfileUpdateModel({this.message, this.data});

  ProfileUpdateModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? ProfileUpdateData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileUpdateData {
  String? rzpContactId;
  String? sId;
  String? role;
  String? profilePic;
  String? fullName;
  String? username;
  String? countryCode;
  int? phoneNumber;
  String? newCountryCode;
  int? newPhoneNumber;
  String? email;
  String? newEmail;
  String? specializationId;
  String? registrationNumber;
  int? totalExperience;
  List<String>? socialProfileUrls;
  String? age;
  String? gender;
  int? fees;
  String? about;
  bool? otpVerified;
  bool? isVerified;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? deviceToken;
  String? deviceType;

  ProfileUpdateData(
      {this.rzpContactId,
        this.sId,
        this.role,
        this.profilePic,
        this.fullName,
        this.username,
        this.countryCode,
        this.phoneNumber,
        this.newCountryCode,
        this.newPhoneNumber,
        this.email,
        this.newEmail,
        this.specializationId,
        this.registrationNumber,
        this.totalExperience,
        this.socialProfileUrls,
        this.age,
        this.gender,
        this.fees,
        this.about,
        this.otpVerified,
        this.isVerified,
        this.isBlocked,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.deviceToken,
        this.deviceType});

  ProfileUpdateData.fromJson(Map<String, dynamic> json) {
    rzpContactId = json['rzpContactId'];
    sId = json['_id'];
    role = json['role'];
    profilePic = json['profilePic'];
    fullName = json['fullName'];
    username = json['username'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    newCountryCode = json['newCountryCode'];
    newPhoneNumber = json['newPhoneNumber'];
    email = json['email'];
    newEmail = json['newEmail'];
    specializationId = json['specializationId'];
    registrationNumber = json['registrationNumber'];
    totalExperience = json['totalExperience'];
    socialProfileUrls = json['socialProfileUrls'].cast<String>();
    age = json['age'];
    gender = json['gender'];
    fees = json['fees'];
    about = json['about'];
    otpVerified = json['otpVerified'];
    isVerified = json['isVerified'];
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    deviceToken = json['deviceToken'];
    deviceType = json['deviceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rzpContactId'] = rzpContactId;
    data['_id'] = sId;
    data['role'] = role;
    data['profilePic'] = profilePic;
    data['fullName'] = fullName;
    data['username'] = username;
    data['countryCode'] = countryCode;
    data['phoneNumber'] = phoneNumber;
    data['newCountryCode'] = newCountryCode;
    data['newPhoneNumber'] = newPhoneNumber;
    data['email'] = email;
    data['newEmail'] = newEmail;
    data['specializationId'] = specializationId;
    data['registrationNumber'] = registrationNumber;
    data['totalExperience'] = totalExperience;
    data['socialProfileUrls'] = socialProfileUrls;
    data['age'] = age;
    data['gender'] = gender;
    data['fees'] = fees;
    data['about'] = about;
    data['otpVerified'] = otpVerified;
    data['isVerified'] = isVerified;
    data['isBlocked'] = isBlocked;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['deviceToken'] = deviceToken;
    data['deviceType'] = deviceType;
    return data;
  }
}
