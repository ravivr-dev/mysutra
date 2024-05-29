import 'package:my_sutra/features/data/model/article_models/article_user_model.dart';

class ArticleIdModel {
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

  ArticleIdModel(
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
        this.isRepostedByMe});

  ArticleIdModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId =
    json['userId'] != null ? ArticleUserModel.fromJson(json['userId']) : null;
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
    return data;
  }
}
