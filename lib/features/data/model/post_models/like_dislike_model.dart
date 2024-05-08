import 'dart:convert';

class LikeDislikeModel {
  final String message;
  final LikeDislikeData data;

  LikeDislikeModel({
    required this.message,
    required this.data,
  });

  factory LikeDislikeModel.fromRawJson(String str) =>
      LikeDislikeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LikeDislikeModel.fromJson(Map<String, dynamic> json) =>
      LikeDislikeModel(
        message: json["message"],
        data: LikeDislikeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class LikeDislikeData {
  final String? likedBy;
  final String postId;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  LikeDislikeData({
    this.likedBy,
    required this.postId,
    this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory LikeDislikeData.fromRawJson(String str) =>
      LikeDislikeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LikeDislikeData.fromJson(Map<String, dynamic> json) =>
      LikeDislikeData(
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
