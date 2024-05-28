import 'package:my_sutra/features/data/model/article_models/article_comment_model.dart';
import 'package:my_sutra/features/data/model/article_models/articles_model.dart';
import 'package:my_sutra/features/data/model/article_models/like_dislike_article_comment_model.dart';
import 'package:my_sutra/features/data/model/article_models/like_dislike_article_model.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_comment_entity.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_id_entity.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_user_entity.dart';
import 'package:my_sutra/features/domain/entities/article_entities/like_dislike_article_comment_entity.dart';
import 'package:my_sutra/features/domain/entities/article_entities/like_dislike_article_entity.dart';

class ArticleRepoConv {
  static List<ArticleEntity> convertGetArticlesModelToEntity(
      ArticlesModel model) {
    return model.data!
        .map((e) => ArticleEntity(
              id: e.id,
              userId: ArticleUserEntity(
                id: e.userId!.id,
                role: e.userId!.role,
                profilePic: e.userId!.profilePic,
                fullName: e.userId!.fullName,
                username: e.userId!.username,
                isVerified: e.userId!.isVerified,
              ),
              heading: e.heading,
              content: e.content,
              isMyArticle: e.isMyArticle,
              isLiked: e.isLiked!,
              isViewed: e.isViewed,
              totalViews: e.totalViews,
              totalLikes: e.totalLikes!,
              totalComments: e.totalComments!,
              totalShares: e.totalShares!,
              repostedArticleCount: e.repostedArticleCount,
              isRepostedByMe: e.isRepostedByMe,
              articleId: e.articleId == null
                  ? null
                  : ArticleIdEntity(
                      id: e.articleId!.id,
                      userId: ArticleUserEntity(
                        id: e.articleId!.userId!.id,
                        role: e.articleId!.userId!.role,
                        profilePic: e.articleId!.userId!.profilePic,
                        fullName: e.articleId!.userId!.fullName,
                        username: e.articleId!.userId!.username,
                        isVerified: e.articleId!.userId!.isVerified,
                      ),
                      heading: e.articleId!.heading,
                      content: e.articleId!.content,
                      isMyArticle: e.articleId!.isMyArticle,
                      isLiked: e.articleId!.isLiked,
                      isViewed: e.articleId!.isViewed,
                      totalViews: e.articleId!.totalViews,
                      totalLikes: e.articleId!.totalLikes,
                      totalComments: e.articleId!.totalComments,
                      totalShares: e.articleId!.totalShares,
                      repostedArticleCount: e.articleId!.repostedArticleCount,
                      isRepostedByMe: e.articleId!.isRepostedByMe,
                    ),
            ))
        .toList();
  }

  static LikeDislikeArticleEntity convertLikeDislikeArticleModelToEntity(
      LikeDislikeArticleModel model) {
    return LikeDislikeArticleEntity(
      likedBy: model.data!.likedBy,
      articleId: model.data!.articleId,
      id: model.data!.id,
      createdAt: model.data!.createdAt,
      updatedAt: model.data!.updatedAt,
      iV: model.data!.iV,
    );
  }

  static List<ArticleCommentEntity> convertArticleCommentModelToEntity(
      ArticleCommentModel model) {
    return model.data!
        .map((e) => ArticleCommentEntity(
              id: e.id,
              articleId: e.articleId,
              userId: ArticleUserEntity(
                id: e.userId!.id,
                role: e.userId!.role,
                profilePic: e.userId!.profilePic,
                fullName: e.userId!.fullName,
                username: e.userId!.username,
                isVerified: e.userId!.isVerified,
              ),
              comment: e.comment,
              isMyComment: e.isMyComment,
              isLiked: e.isLiked,
              totalLikes: e.totalLikes,
              replies: e.replies?.map((e) => RepliesEntity()).toList(),
              createdAt: e.createdAt,
              updatedAt: e.updatedAt,
            ))
        .toList();
  }

  static LikeDislikeArticleCommentEntity
      convertLikeDislikeArticleCommentModelToEntity(
          LikeDislikeArticleCommentModel model) {
    return LikeDislikeArticleCommentEntity(
      likedBy: model.data!.likedBy,
      articleId: model.data!.articleId,
      commentId: model.data!.commentId,
      id: model.data!.sId,
      createdAt: model.data!.createdAt,
      updatedAt: model.data!.updatedAt,
      iV: model.data!.iV,
    );
  }
}
