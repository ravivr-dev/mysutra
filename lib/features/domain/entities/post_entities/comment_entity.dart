import 'package:my_sutra/features/domain/entities/post_entities/post_user_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/reply_entity.dart';

class CommentEntity {
  String id;
  PostUserEntity userId;
  bool isFollowing;
  String comment;
  bool isMyComment;
  bool isLiked;
  int totalLikes;
  int totalReplies;
  DateTime createdAt;
  DateTime updatedAt;
  List<ReplyEntity> replies;

  CommentEntity({
    required this.id,
    required this.userId,
    required this.isFollowing,
    required this.comment,
    required this.isMyComment,
    required this.isLiked,
    required this.totalLikes,
    required this.totalReplies,
    required this.createdAt,
    required this.updatedAt,
    required this.replies,
  });

  void reInitIsFollowing() {
    isFollowing = !isFollowing;
  }

  void reInitIsLiked() {
    isLiked = !isLiked;

    if (isLiked) {
      totalLikes += 1;
    } else {
      totalLikes -= 1;
    }
  }
}
