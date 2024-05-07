import 'package:my_sutra/features/data/model/post_models/posts_model.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';

class PostRepoConv {
  static List<PostEntity> convertPostsModelToEntity(List<PostData> data) {
    return data
        .map((e) => PostEntity(
            id: e.id,
            userId: UserIdEntity(
              id: e.userId.id,
              role: e.userId.role,
              profilePic: e.userId.profilePic,
              fullName: e.userId.profilePic,
              username: e.userId.username,
              isVerified: e.userId.isVerified,
            ),
            isFollowing: e.isFollowing,
            content: e.content,
            mediaUrls: e.mediaUrls
                .map((e) => MediaUrlEntity(mediaType: e.mediaType, url: e.url))
                .toList(),
            taggedUserIds: e.taggedUserIds,
            totalLikes: e.totalLikes,
            totalComments: e.totalComments,
            totalShares: e.totalShares,
            isMyPost: e.isMyPost,
            createdAt: e.createdAt,
            updatedAt: e.updatedAt))
        .toList();
  }
}
