import 'dart:convert';

class CommentLikeDislikeModel {
  final String message;
  final CommentLikeDislikeData data;

  CommentLikeDislikeModel({
    required this.message,
    required this.data,
  });

  factory CommentLikeDislikeModel.fromRawJson(String str) => CommentLikeDislikeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentLikeDislikeModel.fromJson(Map<String, dynamic> json) => CommentLikeDislikeModel(
    message: json["message"],
    data: CommentLikeDislikeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class CommentLikeDislikeData {
  final String? likedBy;
  final String? postId;
  final String commentId;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  CommentLikeDislikeData({
    required this.likedBy,
    required this.postId,
    required this.commentId,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CommentLikeDislikeData.fromRawJson(String str) => CommentLikeDislikeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentLikeDislikeData.fromJson(Map<String, dynamic> json) => CommentLikeDislikeData(
    likedBy: json["likedBy"],
    postId: json["postId"],
    commentId: json["commentId"],
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
    "_id": id,
  };
}
