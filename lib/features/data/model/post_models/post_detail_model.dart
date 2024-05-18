import 'dart:convert';

import 'package:my_sutra/features/data/model/post_models/media_url_model.dart';
import 'package:my_sutra/features/data/model/post_models/post_id_model.dart';
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

  factory PostDetailModel.fromJson(Map<String, dynamic> json) =>
      PostDetailModel(
        message: json["message"],
        data: PostDetailData.fromJson(json["data"]),
      );
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
  int repostCount;
  bool isMyPost;
  bool isLiked;
  bool isRepostedByMe;
  DateTime createdAt;
  DateTime updatedAt;
  PostIdModel? postId;

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
    required this.repostCount,
    required this.isMyPost,
    required this.isLiked,
    required this.isRepostedByMe,
    required this.createdAt,
    required this.updatedAt,
    this.postId,
  });

  factory PostDetailData.fromRawJson(String str) =>
      PostDetailData.fromJson(json.decode(str));

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
      repostCount: json["repostCount"],
      isMyPost: json["isMyPost"],
      isLiked: json["isLiked"],
      isRepostedByMe: json["isRepostedByMe"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      postId:
          json["postId"] == null ? null : PostIdModel.fromJson(json["postId"]));
}
