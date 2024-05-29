import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/article_repository.dart';

class WriteCommentUsecase extends UseCase<String, WriteCommentParams> {
  final ArticleRepository _articleRepository;

  WriteCommentUsecase(this._articleRepository);

  @override
  Future<Either<Failure, String>> call(WriteCommentParams params) {
    return _articleRepository.writeComment(params);
  }
}

class WriteCommentParams {
  final String articleId;
  final String comment;

  WriteCommentParams({required this.articleId, required this.comment});
}
