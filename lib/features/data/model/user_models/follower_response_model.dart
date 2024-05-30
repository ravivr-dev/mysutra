class FollowerModel {
  String? message;
  int? count;
  List<FollowersData>? data;

  FollowerModel({this.message, this.count, this.data});

  FollowerModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <FollowersData>[];
      json['data'].forEach((v) {
        data!.add(FollowersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['count'] = count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FollowersData {
  String? id;
  String? role;
  String? profilePic;
  String? fullName;
  String? username;
  bool? isVerified;
  String? specialization;
  int? totalFollowers;
  bool? isFollowing;

  FollowersData(
      {this.id,
        this.role,
        this.profilePic,
        this.fullName,
        this.username,
        this.isVerified,
        this.specialization,
        this.totalFollowers,
        this.isFollowing});

  FollowersData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    role = json['role'];
    profilePic = json['profilePic'];
    fullName = json['fullName'];
    username = json['username'];
    isVerified = json['isVerified'];
    specialization = json['specialization'];
    totalFollowers = json['totalFollowers'];
    isFollowing = json['isFollowing'];
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
    data['totalFollowers'] = totalFollowers;
    data['isFollowing'] = isFollowing;
    return data;
  }
}
