import 'package:my_sutra/features/domain/entities/article_entities/article_user_entity.dart';

class ArticleIdEntity {
  String? id;
  ArticleUserEntity? userId;
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

  ArticleIdEntity({
    this.id,
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
  });
}
