import 'dart:convert';

class ReplyLikeDislikeModel {
  final String message;
  final ReplyLikeDislikeData data;

  ReplyLikeDislikeModel({
    required this.message,
    required this.data,
  });

  factory ReplyLikeDislikeModel.fromRawJson(String str) =>
      ReplyLikeDislikeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReplyLikeDislikeModel.fromJson(Map<String, dynamic> json) =>
      ReplyLikeDislikeModel(
        message: json["message"],
        data: ReplyLikeDislikeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class ReplyLikeDislikeData {
  final String? likedBy;
  final String? postId;
  final String? commentId;
  final String replyId;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  ReplyLikeDislikeData({
    required this.likedBy,
    required this.postId,
    required this.commentId,
    required this.replyId,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ReplyLikeDislikeData.fromRawJson(String str) =>
      ReplyLikeDislikeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReplyLikeDislikeData.fromJson(Map<String, dynamic> json) =>
      ReplyLikeDislikeData(
        likedBy: json["likedBy"],
        postId: json["postId"],
        commentId: json["commentId"],
        replyId: json["replyId"],
        id: json["_id"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "likedBy": likedBy,
        "postId": postId,
        "commentId": commentId,
        "replyId": replyId,
        "_id": id,
        "__v": v,
      };
}
