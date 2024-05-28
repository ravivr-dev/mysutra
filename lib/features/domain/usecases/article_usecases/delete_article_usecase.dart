import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/article_repository.dart';

class DeleteArticleUsecase extends UseCase<String, String> {
  final ArticleRepository _articleRepository;

  DeleteArticleUsecase(this._articleRepository);

  @override
  Future<Either<Failure, String>> call(String params) {
    return _articleRepository.deleteArticle(params);
  }
}