import 'package:my_sutra/features/data/model/article_models/artice_media_urls_model.dart';
import 'package:my_sutra/features/data/model/article_models/article_id_model.dart';
import 'package:my_sutra/features/data/model/article_models/article_user_model.dart';

class ArticlesModel {
  String? message;
  int? count;
  List<ArticleData>? data;

  ArticlesModel({this.message, this.count, this.data});

  ArticlesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <ArticleData>[];
      json['data'].forEach((v) {
        data!.add(ArticleData.fromJson(v));
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

class ArticleData {
  String? id;
  ArticleUserModel? userId;
  String? heading;
  String? content;
  List<ArticleMediaUrlsModel>? mediaUrls;
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

  ArticleData(
      {this.id,
      this.userId,
      this.heading,
      this.content,
      this.mediaUrls,
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

  ArticleData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'] != null
        ? ArticleUserModel.fromJson(json['userId'])
        : null;
    heading = json['heading'];
    content = json['content'];
    if (json['mediaUrls'] != null) {
      mediaUrls = <ArticleMediaUrlsModel>[];
      json['mediaUrls'].forEach((v) {
        mediaUrls!.add(ArticleMediaUrlsModel.fromJson(v));
      });
    }
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
    if (mediaUrls != null) {
      data['mediaUrls'] = mediaUrls!.map((v) => v.toJson()).toList();
    }
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
