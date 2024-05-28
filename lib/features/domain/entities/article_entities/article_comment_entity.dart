import 'package:my_sutra/features/domain/entities/article_entities/article_user_entity.dart';

class ArticleCommentEntity {
  String? id;
  String? articleId;
  ArticleUserEntity? userId;
  String? comment;
  bool? isMyComment;
  bool? isLiked;
  int? totalLikes;
  List<RepliesEntity>? replies;
  String? createdAt;
  String? updatedAt;

  ArticleCommentEntity(
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
}

class RepliesEntity {
  String? id;
  ArticleUserEntity? userId;
  String? reply;
  bool? isMyReply;
  bool? isLiked;
  int? totalLikes;
  String? createdAt;
  String? updatedAt;

  RepliesEntity(
      {this.id,
      this.userId,
      this.reply,
      this.isMyReply,
      this.isLiked,
      this.totalLikes,
      this.createdAt,
      this.updatedAt});
}
