import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';
import 'package:my_sutra/features/domain/repositories/article_repository.dart';

class ArticleDetailUsecase extends UseCase<ArticleEntity, ArticleDetailParams> {
  final ArticleRepository _articleRepository;

  ArticleDetailUsecase(this._articleRepository);

  @override
  Future<Either<Failure, ArticleEntity>> call(ArticleDetailParams params) {
    return _articleRepository.getArticleDetail(params);
  }
}

class ArticleDetailParams {
  final String articleId;

  ArticleDetailParams({required this.articleId});
}
