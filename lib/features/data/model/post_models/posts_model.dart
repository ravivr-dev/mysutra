import 'dart:convert';

class PostModel {
  final String message;
  final int count;
  final List<PostData> data;

  PostModel({
    required this.message,
    required this.count,
    required this.data,
  });

  factory PostModel.fromRawJson(String str) =>
      PostModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        message: json["message"],
        count: json["count"],
        data:
            List<PostData>.from(json["data"].map((x) => PostData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PostData {
  final String id;
  final UserIdModel userId;
  final bool isFollowing;
  final String content;
  final List<MediaUrlModel> mediaUrls;
  final List<String> taggedUserIds;
  final int totalLikes;
  final int totalComments;
  final int totalShares;
  final bool isMyPost;
  final bool isLiked;
  final DateTime createdAt;
  final DateTime updatedAt;

  PostData({
    required this.id,
    required this.userId,
    required this.isFollowing,
    required this.content,
    required this.mediaUrls,
    required this.taggedUserIds,
    required this.totalLikes,
    required this.totalComments,
    required this.totalShares,
    required this.isMyPost,
    required this.isLiked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostData.fromRawJson(String str) =>
      PostData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        id: json["_id"],
        userId: UserIdModel.fromJson(json["userId"]),
        isFollowing: json["isFollowing"],
        content: json["content"],
        mediaUrls: List<MediaUrlModel>.from(
            json["mediaUrls"].map((x) => MediaUrlModel.fromJson(x))),
        taggedUserIds: List<String>.from(json["taggedUserIds"].map((x) => x)),
        totalLikes: json["totalLikes"],
        totalComments: json["totalComments"],
        totalShares: json["totalShares"],
        isMyPost: json["isMyPost"],
        isLiked: json["isLiked"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "isFollowing": isFollowing,
        "content": content,
        "mediaUrls": List<dynamic>.from(mediaUrls.map((x) => x.toJson())),
        "taggedUserIds": List<dynamic>.from(taggedUserIds.map((x) => x)),
        "totalLikes": totalLikes,
        "totalComments": totalComments,
        "totalShares": totalShares,
        "isMyPost": isMyPost,
        "isLiked": isLiked,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class MediaUrlModel {
  final String mediaType;
  final String url;

  MediaUrlModel({
    required this.mediaType,
    required this.url,
  });

  factory MediaUrlModel.fromRawJson(String str) =>
      MediaUrlModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MediaUrlModel.fromJson(Map<String, dynamic> json) => MediaUrlModel(
        mediaType: json["mediaType"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "mediaType": mediaType,
        "url": url,
      };
}

class UserIdModel {
  final String id;
  final String role;
  final String? profilePic;
  final String fullName;
  final String username;
  final bool isVerified;

  UserIdModel({
    required this.id,
    required this.role,
    this.profilePic,
    required this.fullName,
    required this.username,
    required this.isVerified,
  });

  factory UserIdModel.fromRawJson(String str) =>
      UserIdModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserIdModel.fromJson(Map<String, dynamic> json) => UserIdModel(
        id: json["_id"],
        role: json["role"],
        profilePic: json["profilePic"],
        fullName: json["fullName"],
        username: json["username"],
        isVerified: json["isVerified"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "role": role,
        "profilePic": profilePic,
        "fullName": fullName,
        "username": username,
        "isVerified": isVerified,
      };
}
