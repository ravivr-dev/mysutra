import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/create_article_usecase.dart';

abstract class ArticleRepository {
  Future<Either<Failure, String>> createArticle(CreateArticleParams params);
}
