import 'dart:convert';

import 'package:my_sutra/features/data/model/post_models/media_url_model.dart';
import 'package:my_sutra/features/data/model/post_models/post_user_model.dart';

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
  final PostUserModel userId;
  final bool isFollowing;
  final String content;
  final List<MediaUrlModel> mediaUrls;
  final List<String> taggedUserIds;
  final int totalLikes;
  final int totalComments;
  final int totalShares;
  final int repostCount;
  final bool isMyPost;
  final bool isLiked;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PostIdModel? postId;

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
    required this.repostCount,
    required this.isMyPost,
    required this.isLiked,
    required this.createdAt,
    required this.updatedAt,
    this.postId,
  });

  factory PostData.fromRawJson(String str) =>
      PostData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
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
        repostCount: json["repostCount"],
        isMyPost: json["isMyPost"],
        isLiked: json["isLiked"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        postId: json["postId"] == null
            ? null
            : PostIdModel.fromJson(json["postId"]),
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
        "repostCount": repostCount,
        "isMyPost": isMyPost,
        "isLiked": isLiked,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "postId": postId!.toJson(),
      };
}

class PostIdModel {
  final String id;
  final PostUserModel userId;
  final bool isFollowing;
  final String content;
  final List<dynamic> mediaUrls;
  final List<dynamic> taggedUserIds;
  final int totalLikes;
  final int totalComments;
  final int totalShares;
  final int repostCount;
  final bool isMyPost;
  final bool isLiked;
  final bool isRepostedByMe;
  final DateTime createdAt;
  final DateTime updatedAt;

  PostIdModel({
    required this.id,
    required this.userId,
    required this.isFollowing,
    required this.content,
    required this.mediaUrls,
    required this.taggedUserIds,
    required this.totalLikes,
    required this.totalComments,
    required this.totalShares,
    required this.repostCount,
    required this.isMyPost,
    required this.isLiked,
    required this.isRepostedByMe,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostIdModel.fromRawJson(String str) =>
      PostIdModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostIdModel.fromJson(Map<String, dynamic> json) => PostIdModel(
        id: json["_id"],
        userId: PostUserModel.fromJson(json["userId"]),
        isFollowing: json["isFollowing"],
        content: json["content"],
        mediaUrls: List<dynamic>.from(json["mediaUrls"].map((x) => x)),
        taggedUserIds: List<dynamic>.from(json["taggedUserIds"].map((x) => x)),
        totalLikes: json["totalLikes"],
        totalComments: json["totalComments"],
        totalShares: json["totalShares"],
        repostCount: json["repostCount"],
        isMyPost: json["isMyPost"],
        isLiked: json["isLiked"],
        isRepostedByMe: json["isRepostedByMe"],
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
        "repostCount": repostCount,
        "isMyPost": isMyPost,
        "isLiked": isLiked,
        "isRepostedByMe": isRepostedByMe,
      };
}
