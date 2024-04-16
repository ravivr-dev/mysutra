class FollowModel {
  final String? role;
  final String? followedUserId;
  final String? followerUserId;
  final String? id;
  final String? createdAt;
  final String? updateAt;

  FollowModel({
    required this.role,
    required this.followedUserId,
    required this.followerUserId,
    required this.id,
    required this.createdAt,
    required this.updateAt,
  });

  FollowModel.fromJson(Map<String, dynamic> map)
      : role = map['role'],
        followerUserId = map['followedUserId'],
        followedUserId = map['followerUserId'],
        id = map['_id'],
        createdAt = map['createdAt'],
        updateAt = map['updatedAt'];
}
