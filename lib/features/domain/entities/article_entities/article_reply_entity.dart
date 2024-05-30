import 'package:my_sutra/features/domain/entities/article_entities/article_user_entity.dart';

class ArticleRepliesEntity {
  String? id;
  ArticleUserEntity? userId;
  String? reply;
  bool? isMyReply;
  bool? isLiked;
  int? totalLikes;
  String? createdAt;
  String? updatedAt;

  ArticleRepliesEntity(
      {this.id,
      this.userId,
      this.reply,
      this.isMyReply,
      this.isLiked,
      this.totalLikes,
      this.createdAt,
      this.updatedAt});
}
