import 'package:my_sutra/features/data/model/post_models/comment_like_dislike_model.dart';
import 'package:my_sutra/features/data/model/post_models/comment_model.dart';
import 'package:my_sutra/features/data/model/post_models/post_like_dislike_model.dart';
import 'package:my_sutra/features/data/model/post_models/post_detail_model.dart';
import 'package:my_sutra/features/data/model/post_models/posts_model.dart';
import 'package:my_sutra/features/data/model/post_models/reply_like_dislike_model.dart';
import 'package:my_sutra/features/domain/entities/post_entities/comment_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/comment_like_dislike_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_id_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_like_dislike_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/media_urls_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_detail_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_user_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/reply_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/reply_like_dislike_entity.dart';

class PostRepoConv {
  static List<PostEntity> convertPostsModelToEntity(List<PostData> data) {
    return data
        .map((e) => PostEntity(
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
            repostCount: e.repostCount,
            isMyPost: e.isMyPost,
            isLiked: e.isLiked,
            createdAt: e.createdAt,
            updatedAt: e.updatedAt,
            postId: e.postId == null
                ? null
                : PostIdEntity(
                    id: e.postId!.id,
                    userId: PostUserEntity(
                      id: e.postId!.userId.id,
                      role: e.postId!.userId.role,
                      profilePic: e.postId!.userId.profilePic,
                      fullName: e.postId!.userId.fullName,
                      username: e.postId!.userId.username,
                      isVerified: e.postId!.userId.isVerified,
                    ),
                    isFollowing: e.postId!.isFollowing,
                    content: e.postId!.content,
                    mediaUrls: e.postId!.mediaUrls
                        .map((e) =>
                            MediaUrlEntity(mediaType: e.mediaType, url: e.url))
                        .toList(),
                    taggedUserIds: e.postId!.taggedUserIds,
                    totalLikes: e.postId!.totalLikes,
                    totalComments: e.postId!.totalComments,
                    totalShares: e.postId!.totalShares,
                    repostCount: e.postId!.repostCount,
                    isMyPost: e.postId!.isMyPost,
                    isLiked: e.postId!.isLiked,
                    isRepostedByMe: e.postId!.isRepostedByMe,
                    createdAt: e.postId!.createdAt,
                    updatedAt: e.postId!.updatedAt)))
        .toList();
  }

  static PostLikeDislikeEntity convertPostLikeDislikeModelToEntity(
      PostLikeDislikeModel model) {
    if (model.data.likedBy != null) {
      return PostLikeDislikeEntity(
          likedBy: model.data.likedBy,
          postId: model.data.postId,
          id: model.data.id);
    } else {
      return PostLikeDislikeEntity(postId: model.data.postId);
    }
  }

  static ReplyLikeDislikeEntity convertReplyLikeDislikeModelToEntity(
      ReplyLikeDislikeModel model) {
    if (model.data.likedBy != null) {
      return ReplyLikeDislikeEntity(
          likedBy: model.data.likedBy,
          postId: model.data.postId,
          id: model.data.id,
          commentId: model.data.commentId,
          replyId: model.data.replyId);
    } else {
      return ReplyLikeDislikeEntity(replyId: model.data.replyId);
    }
  }

  static CommentLikeDislikeEntity convertCommentLikeDislikeModelToEntity(
      CommentLikeDislikeModel model) {
    if (model.data.likedBy != null) {
      return CommentLikeDislikeEntity(
          likedBy: model.data.likedBy,
          postId: model.data.postId,
          commentId: model.data.commentId,
          id: model.data.id);
    } else {
      return CommentLikeDislikeEntity(commentId: model.data.commentId);
    }
  }

  static PostDetailEntity convertPostDetailModelToEntity(PostDetailData data) {
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
        repostCount: data.repostCount,
        isMyPost: data.isMyPost,
        isLiked: data.isLiked,
        isRepostedByMe: data.isRepostedByMe,
        createdAt: data.createdAt,
        updatedAt: data.updatedAt,
        postId: data.postId == null
            ? null
            : PostIdEntity(
                id: data.postId!.id,
                userId: PostUserEntity(
                    id: data.postId!.userId.id,
                    role: data.postId!.userId.role,
                    profilePic: data.postId!.userId.profilePic,
                    username: data.postId!.userId.username,
                    fullName: data.postId!.userId.fullName,
                    isVerified: data.postId!.userId.isVerified),
                isFollowing: data.postId!.isFollowing,
                content: data.postId!.content,
                mediaUrls: data.postId!.mediaUrls
                    .map((e) =>
                        MediaUrlEntity(mediaType: e.mediaType, url: e.url))
                    .toList(),
                taggedUserIds: data.postId!.taggedUserIds,
                totalLikes: data.postId!.totalLikes,
                totalComments: data.postId!.totalComments,
                totalShares: data.postId!.totalShares,
                repostCount: data.postId!.repostCount,
                isMyPost: data.postId!.isMyPost,
                isLiked: data.postId!.isLiked,
                isRepostedByMe: data.postId!.isRepostedByMe,
                createdAt: data.postId!.createdAt,
                updatedAt: data.postId!.updatedAt));
  }

  static List<CommentEntity> convertCommentModelToEntity(CommentModel model) {
    return model.data
        .map((e) => CommentEntity(
            id: e.id,
            userId: PostUserEntity(
                id: e.userId.id,
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
            replies: e.replies
                .map((e) => ReplyEntity(
                    id: e.id,
                    userId: PostUserEntity(
                        id: e.userId.id,
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
                    updatedAt: e.updatedAt))
                .toList()))
        .toList();
  }
}
