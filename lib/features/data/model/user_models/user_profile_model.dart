class UserProfileModel {
  String? message;
  UserProfileData? data;

  UserProfileModel({this.message, this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? UserProfileData.fromJson(json['data']) : null;
  }
}

class UserProfileData {
  String? id;
  String? profilePic;
  String? name;
  String? countryCode;
  int? phoneNumber;
  String? email;

  UserProfileData(
      {this.id,
        this.profilePic,
        this.name,
        this.countryCode,
        this.phoneNumber,
        this.email});

  UserProfileData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    profilePic = json['profilePic'];
    name = json['name'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
  }
}
