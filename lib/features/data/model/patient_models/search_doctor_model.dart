class SearchDoctorModel {
  String? message;
  int? count;
  List<DoctorDataModel>? data;

  SearchDoctorModel({this.message, this.count, this.data});

  SearchDoctorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <DoctorDataModel>[];
      json['data'].forEach((v) {
        data!.add(DoctorDataModel.fromJson(v));
      });
    }
  }
}

class DoctorDataModel {
  String? id;
  String? profilePic;
  String? fullName;
  String? specialization;
  int? ratings;
  int? reviews;
  int? fees;
  bool? isFollowing;

  DoctorDataModel(
      {this.id,
      this.profilePic,
      this.fullName,
      this.specialization,
      this.ratings,
      this.reviews,
      this.fees,
      this.isFollowing});

  DoctorDataModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    profilePic = json['profilePic'];
    fullName = json['fullName'];
    specialization = json['specialization'];
    ratings = json['ratings'];
    reviews = json['reviews'];
    fees = json['fees'];
    isFollowing = json['isFollowing'];
  }
}
