class FollowUserModel {
  String? message;
  FollowUserData? data;

  FollowUserModel({this.message, this.data});

  FollowUserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? FollowUserData.fromJson(json['data']) : null;
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

class FollowUserData {
  String? role;
  String? followedUserId;
  String? followerUserId;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FollowUserData(
      {this.role,
        this.followedUserId,
        this.followerUserId,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.iV});

  FollowUserData.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    followedUserId = json['followedUserId'];
    followerUserId = json['followerUserId'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['followedUserId'] = followedUserId;
    data['followerUserId'] = followerUserId;
    data['_id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
