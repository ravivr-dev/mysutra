import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_comment_entity.dart';
import 'package:my_sutra/features/domain/repositories/article_repository.dart';

class GetArticleCommentUsecase
    extends UseCase<List<ArticleCommentEntity>, ArticleCommentParams> {
  final ArticleRepository _articleRepository;

  GetArticleCommentUsecase(this._articleRepository);

  @override
  Future<Either<Failure, List<ArticleCommentEntity>>> call(
      ArticleCommentParams params) {
    return _articleRepository.getArticleComment(params);
  }
}

class ArticleCommentParams {
  final String articleId;
  final int pagination;
  final int limit;

  ArticleCommentParams(
      {required this.articleId, required this.pagination, required this.limit});
}
