class LikeDislikeArticleCommentModel {
  String? message;
  LikeDislikeArticleCommentData? data;

  LikeDislikeArticleCommentModel({this.message, this.data});

  LikeDislikeArticleCommentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? LikeDislikeArticleCommentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LikeDislikeArticleCommentData {
  String? likedBy;
  String? articleId;
  String? commentId;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LikeDislikeArticleCommentData(
      {this.likedBy,
      this.articleId,
      this.commentId,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  LikeDislikeArticleCommentData.fromJson(Map<String, dynamic> json) {
    likedBy = json['likedBy'];
    articleId = json['articleId'];
    commentId = json['commentId'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['likedBy'] = likedBy;
    data['articleId'] = articleId;
    data['commentId'] = commentId;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
