import 'package:my_sutra/features/domain/entities/article_entities/article_reply_entity.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_user_entity.dart';

class ArticleCommentEntity {
  String? id;
  String? articleId;
  ArticleUserEntity? userId;
  String? comment;
  bool? isMyComment;
  bool isLiked;
  int totalLikes;
  List<ArticleRepliesEntity>? replies;
  String? createdAt;
  String? updatedAt;

  ArticleCommentEntity(
      {this.id,
      this.articleId,
      this.userId,
      this.comment,
      this.isMyComment,
      required this.isLiked,
      required this.totalLikes,
      this.replies,
      this.createdAt,
      this.updatedAt});

  void reInitIsLiked() {
    isLiked = !isLiked;

    if (isLiked) {
      totalLikes += 1;
    } else {
      totalLikes -= 1;
    }
  }
}
