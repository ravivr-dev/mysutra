import 'package:my_sutra/features/data/model/article_models/article_id_model.dart';
import 'package:my_sutra/features/data/model/article_models/article_user_model.dart';

class ArticleDetailModel {
  String? message;
  ArticleDetailData? data;

  ArticleDetailModel({this.message, this.data});

  ArticleDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? ArticleDetailData.fromJson(json['data']) : null;
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

class ArticleDetailData {
  String? id;
  ArticleUserModel? userId;
  String? heading;
  String? content;
  bool? isMyArticle;
  bool? isLiked;
  bool? isViewed;
  int? totalViews;
  int? totalLikes;
  int? totalComments;
  int? totalShares;
  int? repostedArticleCount;
  bool? isRepostedByMe;
  ArticleIdModel? articleId;

  ArticleDetailData(
      {this.id,
      this.userId,
      this.heading,
      this.content,
      this.isMyArticle,
      this.isLiked,
      this.isViewed,
      this.totalViews,
      this.totalLikes,
      this.totalComments,
      this.totalShares,
      this.repostedArticleCount,
      this.isRepostedByMe,
      this.articleId});

  ArticleDetailData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'] != null
        ? ArticleUserModel.fromJson(json['userId'])
        : null;
    heading = json['heading'];
    content = json['content'];
    isMyArticle = json['isMyArticle'];
    isLiked = json['isLiked'];
    isViewed = json['isViewed'];
    totalViews = json['totalViews'];
    totalLikes = json['totalLikes'];
    totalComments = json['totalComments'];
    totalShares = json['totalShares'];
    repostedArticleCount = json['repostedArticleCount'];
    isRepostedByMe = json['isRepostedByMe'];
    articleId = json['articleId'] != null
        ? ArticleIdModel.fromJson(json['articleId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    data['heading'] = heading;
    data['content'] = content;
    data['isMyArticle'] = isMyArticle;
    data['isLiked'] = isLiked;
    data['isViewed'] = isViewed;
    data['totalViews'] = totalViews;
    data['totalLikes'] = totalLikes;
    data['totalComments'] = totalComments;
    data['totalShares'] = totalShares;
    data['repostedArticleCount'] = repostedArticleCount;
    data['isRepostedByMe'] = isRepostedByMe;
    if (articleId != null) {
      data['articleId'] = articleId!.toJson();
    }
    return data;
  }
}
