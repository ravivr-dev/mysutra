import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_media_urls_entity.dart';
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
  final List<ArticleMediaUrlEntity> mediaUrls;

  CreateArticleParams(
      {this.articleId,
      required this.heading,
      required this.content,
      required this.mediaUrls});
}
