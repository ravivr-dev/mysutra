import 'dart:convert';

import 'package:my_sutra/features/data/model/post_models/media_url_model.dart';
import 'package:my_sutra/features/data/model/post_models/post_user_model.dart';

class PostDetailModel {
  String message;
  PostDetailData data;

  PostDetailModel({
    required this.message,
    required this.data,
  });

  factory PostDetailModel.fromRawJson(String str) =>
      PostDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostDetailModel.fromJson(Map<String, dynamic> json) =>
      PostDetailModel(
        message: json["message"],
        data: PostDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class PostDetailData {
  String id;
  PostUserModel userId;
  bool isFollowing;
  String content;
  List<MediaUrlModel> mediaUrls;
  List<String> taggedUserIds;
  int totalLikes;
  int totalComments;
  int totalShares;
  bool isMyPost;
  bool isLiked;
  DateTime createdAt;
  DateTime updatedAt;

  PostDetailData({
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

  factory PostDetailData.fromRawJson(String str) =>
      PostDetailData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostDetailData.fromJson(Map<String, dynamic> json) => PostDetailData(
        id: json["_id"],
        userId: PostUserModel.fromJson(json["userId"]),
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
        "mediaUrls": List<dynamic>.from(mediaUrls.map((x) => x)),
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
