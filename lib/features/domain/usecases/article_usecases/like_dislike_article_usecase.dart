import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/article_entities/like_dislike_article_entity.dart';
import 'package:my_sutra/features/domain/repositories/article_repository.dart';

class LikeDislikeArticleUsecase
    extends UseCase<LikeDislikeArticleEntity, LikeDislikeArticleParams> {

  final ArticleRepository _articleRepository;

  LikeDislikeArticleUsecase(this._articleRepository);
  @override
  Future<Either<Failure, LikeDislikeArticleEntity>> call(LikeDislikeArticleParams params) {
    return _articleRepository.likeDislikeArticle(params);
  }
}

class LikeDislikeArticleParams {
  final String articleId;

  LikeDislikeArticleParams({required this.articleId});
}
