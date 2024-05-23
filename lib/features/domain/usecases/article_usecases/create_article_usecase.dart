import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/article_repository.dart';

class CreateArticleUsecase extends UseCase<String, CreateArticleParams> {
  final ArticleRepository _articleRepository;

  CreateArticleUsecase(this._articleRepository);

  @override
  Future<Either<Failure, String>> call(CreateArticleParams params) {
    return _articleRepository.createArticle(params);
  }
}

class CreateArticleParams {
  final String? articleId;
  final String heading;
  final String content;

  CreateArticleParams(
      {this.articleId, required this.heading, required this.content});
}
