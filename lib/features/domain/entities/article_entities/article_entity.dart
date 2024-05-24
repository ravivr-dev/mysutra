import 'package:my_sutra/features/domain/entities/article_entities/article_id_entity.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_user_entity.dart';

class ArticleEntity {
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
  ArticleIdEntity? articleId;

  ArticleEntity({
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
    this.articleId,
  });
}
