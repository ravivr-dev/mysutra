import 'package:my_sutra/features/data/model/article_models/article_user_model.dart';

class ArticleCommentModel {
  String? message;
  int? count;
  List<ArticleCommentData>? data;

  ArticleCommentModel({this.message, this.count, this.data});

  ArticleCommentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <ArticleCommentData>[];
      json['data'].forEach((v) {
        data!.add(ArticleCommentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['count'] = count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArticleCommentData {
  String? id;
  String? articleId;
  ArticleUserModel? userId;
  String? comment;
  bool? isMyComment;
  bool? isLiked;
  int? totalLikes;
  List<Replies>? replies;
  String? createdAt;
  String? updatedAt;

  ArticleCommentData(
      {this.id,
      this.articleId,
      this.userId,
      this.comment,
      this.isMyComment,
      this.isLiked,
      this.totalLikes,
      this.replies,
      this.createdAt,
      this.updatedAt});

  ArticleCommentData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    articleId = json['articleId'];
    userId = json['userId'] != null
        ? ArticleUserModel.fromJson(json['userId'])
        : null;
    comment = json['comment'];
    isMyComment = json['isMyComment'];
    isLiked = json['isLiked'];
    totalLikes = json['totalLikes'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['articleId'] = articleId;
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    data['comment'] = comment;
    data['isMyComment'] = isMyComment;
    data['isLiked'] = isLiked;
    data['totalLikes'] = totalLikes;
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Replies {
  String? id;
  ArticleUserModel? userId;
  String? reply;
  bool? isMyReply;
  bool? isLiked;
  int? totalLikes;
  String? createdAt;
  String? updatedAt;

  Replies(
      {this.id,
      this.userId,
      this.reply,
      this.isMyReply,
      this.isLiked,
      this.totalLikes,
      this.createdAt,
      this.updatedAt});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'] != null
        ? ArticleUserModel.fromJson(json['userId'])
        : null;
    reply = json['reply'];
    isMyReply = json['isMyReply'];
    isLiked = json['isLiked'];
    totalLikes = json['totalLikes'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    data['reply'] = reply;
    data['isMyReply'] = isMyReply;
    data['isLiked'] = isLiked;
    data['totalLikes'] = totalLikes;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
