import 'package:my_sutra/features/domain/entities/post_entities/post_user_entity.dart';

class ReplyEntity {
  String id;
  PostUserEntity userId;
  String reply;
  bool isFollowing;
  bool isMyReply;
  bool isLiked;
  int totalLikes;
  DateTime createdAt;
  DateTime updatedAt;

  ReplyEntity({
    required this.id,
    required this.userId,
    required this.reply,
    required this.isFollowing,
    required this.isMyReply,
    required this.isLiked,
    required this.totalLikes,
    required this.createdAt,
    required this.updatedAt,
  });

}
