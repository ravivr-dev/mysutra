import 'dart:convert';

import 'package:my_sutra/features/data/model/post_models/post_user_model.dart';
import 'package:my_sutra/features/data/model/reply_model.dart';

class CommentModel {
  String message;
  int count;
  List<CommentData> data;

  CommentModel({
    required this.message,
    required this.count,
    required this.data,
  });

  factory CommentModel.fromRawJson(String str) =>
      CommentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        message: json["message"],
        count: json["count"],
        data: List<CommentData>.from(json["data"].map((x) => CommentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CommentData {
  String id;
  PostUserModel userId;
  bool isFollowing;
  String comment;
  bool isMyComment;
  bool isLiked;
  int totalLikes;
  int totalReplies;
  DateTime createdAt;
  DateTime updatedAt;
  List<ReplyModel> replies;

  CommentData({
    required this.id,
    required this.userId,
    required this.isFollowing,
    required this.comment,
    required this.isMyComment,
    required this.isLiked,
    required this.totalLikes,
    required this.totalReplies,
    required this.createdAt,
    required this.updatedAt,
    required this.replies,
  });

  factory CommentData.fromRawJson(String str) => CommentData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        id: json["_id"],
        userId: PostUserModel.fromJson(json["userId"]),
        isFollowing: json["isFollowing"],
        comment: json["comment"],
        isMyComment: json["isMyComment"],
        isLiked: json["isLiked"],
        totalLikes: json["totalLikes"],
        totalReplies: json["totalReplies"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        replies:
            List<ReplyModel>.from(json["replies"].map((x) => ReplyModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "isFollowing": isFollowing,
        "comment": comment,
        "isMyComment": isMyComment,
        "isLiked": isLiked,
        "totalLikes": totalLikes,
        "totalReplies": totalReplies,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
      };
}
