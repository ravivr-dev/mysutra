import 'package:my_sutra/features/domain/entities/post_entities/media_urls_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_user_entity.dart';

class PostIdEntity {
  String id;
  PostUserEntity userId;
  bool isFollowing;
  String content;
  List<MediaUrlEntity> mediaUrls;
  List<String> taggedUserIds;
  int totalLikes;
  int totalComments;
  int totalShares;
  int repostCount;
  bool isMyPost;
  bool isLiked;
  bool isRepostedByMe;
  DateTime createdAt;
  DateTime updatedAt;

  PostIdEntity({
    required this.id,
    required this.userId,
    required this.isFollowing,
    required this.content,
    required this.mediaUrls,
    required this.taggedUserIds,
    required this.totalLikes,
    required this.totalComments,
    required this.totalShares,
    required this.repostCount,
    required this.isMyPost,
    required this.isLiked,
    required this.isRepostedByMe,
    required this.createdAt,
    required this.updatedAt,
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