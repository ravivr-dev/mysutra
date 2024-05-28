import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/article_entities/like_dislike_article_comment_entity.dart';
import 'package:my_sutra/features/domain/repositories/article_repository.dart';

class LikeDislikeArticleCommentUsecase extends UseCase<
    LikeDislikeArticleCommentEntity, LikeDislikeArticleCommentParams> {
  final ArticleRepository _articleRepository;

  LikeDislikeArticleCommentUsecase(this._articleRepository);

  @override
  Future<Either<Failure, LikeDislikeArticleCommentEntity>> call(LikeDislikeArticleCommentParams params) {
    return _articleRepository.likeDislikeArticleComment(params);
  }
}

class LikeDislikeArticleCommentParams {
  final String commentId;

  LikeDislikeArticleCommentParams({required this.commentId});
}
