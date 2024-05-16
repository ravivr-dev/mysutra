import 'dart:convert';

class PostLikeDislikeModel {
  final String message;
  final PostLikeDislikeData data;

  PostLikeDislikeModel({
    required this.message,
    required this.data,
  });

  factory PostLikeDislikeModel.fromRawJson(String str) =>
      PostLikeDislikeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostLikeDislikeModel.fromJson(Map<String, dynamic> json) =>
      PostLikeDislikeModel(
        message: json["message"],
        data: PostLikeDislikeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class PostLikeDislikeData {
  final String? likedBy;
  final String postId;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PostLikeDislikeData({
    this.likedBy,
    required this.postId,
    this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory PostLikeDislikeData.fromRawJson(String str) =>
      PostLikeDislikeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostLikeDislikeData.fromJson(Map<String, dynamic> json) =>
      PostLikeDislikeData(
        likedBy: json["likedBy"],
        postId: json["postId"],
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
        "_id": id,
      };
}
