import 'package:my_sutra/features/data/model/post_models/comment_model.dart';
import 'package:my_sutra/features/data/model/post_models/like_dislike_model.dart';
import 'package:my_sutra/features/data/model/post_models/post_detail_model.dart';
import 'package:my_sutra/features/data/model/post_models/posts_model.dart';
import 'package:my_sutra/features/domain/entities/post_entities/comment_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/like_dislike_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/media_urls_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_detail_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_user_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/reply_entity.dart';

class PostRepoConv {
  static List<PostEntity> convertPostsModelToEntity(List<PostData> data) {
    return data
        .map((e) =>
        PostEntity(
            id: e.id,
            userId: PostUserEntity(
              id: e.userId.id,
              role: e.userId.role,
              profilePic: e.userId.profilePic,
              fullName: e.userId.fullName,
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
            isLiked: e.isLiked,
            createdAt: e.createdAt,
            updatedAt: e.updatedAt))
        .toList();
  }

  static LikeDislikeEntity convertLikeDisilkeModelToEntity(
      LikeDislikeModel model) {
    if (model.data.likedBy != null) {
      return LikeDislikeEntity(
          likedBy: model.data.likedBy,
          postId: model.data.postId,
          id: model.data.id);
    } else {
      return LikeDislikeEntity(postId: model.data.postId);
    }
  }

  static PostDetailEntity converPostDetailModelToEntity(PostDetailData data) {
    return PostDetailEntity(
        id: data.id,
        userId: PostUserEntity(
            id: data.userId.id,
            role: data.userId.role,
            profilePic: data.userId.profilePic,
            fullName: data.userId.fullName,
            username: data.userId.username,
            isVerified: data.userId.isVerified),
        isFollowing: data.isFollowing,
        content: data.content,
        mediaUrls: data.mediaUrls
            .map((e) => MediaUrlEntity(mediaType: e.mediaType, url: e.url))
            .toList(),
        taggedUserIds: data.taggedUserIds,
        totalLikes: data.totalLikes,
        totalComments: data.totalComments,
        totalShares: data.totalShares,
        isMyPost: data.isMyPost,
        isLiked: data.isLiked,
        createdAt: data.createdAt,
        updatedAt: data.updatedAt);
  }

  static List<CommentEntity> convertCommentModelToEntity(CommentModel model) {
    return model.data.map((e) =>
        CommentEntity(
            id: e.id,
            userId: PostUserEntity(id: e.userId.id,
                role: e.userId.role,
                fullName: e.userId.fullName,
                username: e.userId.username,
                isVerified: e.userId.isVerified),
            isFollowing: e.isFollowing,
            comment: e.comment,
            isMyComment: e.isMyComment,
            isLiked: e.isLiked,
            totalLikes: e.totalLikes,
            totalReplies: e.totalReplies,
            createdAt: e.createdAt,
            updatedAt: e.updatedAt,
            replies: e.replies.map((e) =>
                ReplyEntity(
                    id: e.id,
                    userId: PostUserEntity(id: e.userId.id,
                        role: e.userId.role,
                        fullName: e.userId.fullName,
                        username: e.userId.username,
                        isVerified: e.userId.isVerified),
                    reply: e.reply,
                    isFollowing: e.isFollowing,
                    isMyReply: e.isMyReply,
                    isLiked: e.isLiked,
                    totalLikes: e.totalLikes,
                    createdAt: e.createdAt,
                    updatedAt: e.updatedAt)).toList())).toList();
  }
}
