import 'package:my_sutra/features/domain/entities/post_entities/media_urls_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_user_entity.dart';

class PostIdEntity {
  final String id;
  final PostUserEntity userId;
  final bool isFollowing;
  final String content;
  final List<MediaUrlEntity> mediaUrls;
  final List<String> taggedUserIds;
  final int totalLikes;
  final int totalComments;
  final int totalShares;
  final int repostCount;
  final bool isMyPost;
  final bool isLiked;
  final bool isRepostedByMe;
  final DateTime createdAt;
  final DateTime updatedAt;

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
}
