class LikeDislikeArticleModel {
  String? message;
  LikeDislikeArticleData? data;

  LikeDislikeArticleModel({this.message, this.data});

  LikeDislikeArticleModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? LikeDislikeArticleData.fromJson(json['data'])
        : null;
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

class LikeDislikeArticleData {
  String? likedBy;
  String? articleId;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LikeDislikeArticleData(
      {this.likedBy,
      this.articleId,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.iV});

  LikeDislikeArticleData.fromJson(Map<String, dynamic> json) {
    likedBy = json['likedBy'];
    articleId = json['articleId'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['likedBy'] = likedBy;
    data['articleId'] = articleId;
    data['_id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
