import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/article_repository.dart';

class EditArticleUsecase extends UseCase<String, EditArticleParams> {
  final ArticleRepository articleRepository;

  EditArticleUsecase(this.articleRepository);

  @override
  Future<Either<Failure, String>> call(EditArticleParams params) {
    return articleRepository.editArticle(params);
  }
}

class EditArticleParams {
  final String articleId;
  final String heading;
  final String content;

  EditArticleParams(
      {required this.articleId, required this.heading, required this.content});
}
