import 'dart:convert';

import 'package:my_sutra/features/data/model/post_models/post_user_model.dart';

class ReplyModel {
  String id;
  PostUserModel userId;
  String reply;
  bool isFollowing;
  bool isMyReply;
  bool isLiked;
  int totalLikes;
  DateTime createdAt;
  DateTime updatedAt;

  ReplyModel({
    required this.id,
    required this.userId,
    required this.reply,
    required this.isFollowing,
    required this.isMyReply,
    required this.isLiked,
    required this.totalLikes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReplyModel.fromRawJson(String str) =>
      ReplyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReplyModel.fromJson(Map<String, dynamic> json) => ReplyModel(
        id: json["_id"],
        userId: PostUserModel.fromJson(json["userId"]),
        reply: json["reply"],
        isFollowing: json["isFollowing"],
        isMyReply: json["isMyReply"],
        isLiked: json["isLiked"],
        totalLikes: json["totalLikes"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "reply": reply,
        "isFollowing": isFollowing,
        "isMyReply": isMyReply,
        "isLiked": isLiked,
        "totalLikes": totalLikes,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
