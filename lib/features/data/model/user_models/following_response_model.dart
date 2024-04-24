import 'package:my_sutra/core/utils/constants.dart';

class FollowingResponseModel {
  String message;
  int count;
  List<FollowerData> data;


  FollowingResponseModel({this.message = '', this.count = 0, required this.data});

  FollowingResponseModel.fromJson(Map<String, dynamic> json) :
    message = json[Constants.message],
    count = json[Constants.count],
    data = (json[Constants.data] as List<dynamic>)
        .map((e) => FollowerData.fromJson(e))
        .toList();
}

class FollowerData {
  String? id;
  String? role;
  String? profilePic;
  String? fullName;
  String? username;
  bool? isVerified;
  String? specialization;
  bool? isFollowing;
  int? totalFollowers;

  FollowerData(
      {this.id,
        this.role,
        this.profilePic,
        this.fullName,
        this.username,
        this.isVerified,
        this.specialization,
        this.isFollowing,
        this.totalFollowers});

  FollowerData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    role = json['role'];
    profilePic = json['profilePic'];
    fullName = json['fullName'];
    username = json['username'];
    isVerified = json['isVerified'];
    specialization = json['specialization'];
    isFollowing = json['isFollowing'];
    totalFollowers = json['totalFollowers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['role'] = role;
    data['profilePic'] = profilePic;
    data['fullName'] = fullName;
    data['username'] = username;
    data['isVerified'] = isVerified;
    data['specialization'] = specialization;
    data['isFollowing'] = isFollowing;
    data['totalFollowers'] = totalFollowers;
    return data;
  }
}
