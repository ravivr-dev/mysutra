import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';
import 'package:my_sutra/features/domain/repositories/article_repository.dart';

class GetArticlesUsecase
    extends UseCase<List<ArticleEntity>, GetArticlesParams> {
  final ArticleRepository _articleRepository;

  GetArticlesUsecase(this._articleRepository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(GetArticlesParams params) {
    return _articleRepository.getArticles(params);
  }
}

class GetArticlesParams {
  final int pagination;
  final int limit;

  GetArticlesParams({required this.pagination, required this.limit});
}
