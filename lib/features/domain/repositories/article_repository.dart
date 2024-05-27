import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';
import 'package:my_sutra/features/domain/entities/article_entities/like_dislike_article_entity.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/create_article_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/get_articles_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/like_dislike_article_usecase.dart';

abstract class ArticleRepository {
  Future<Either<Failure, String>> createArticle(CreateArticleParams params);

  Future<Either<Failure, List<ArticleEntity>>> getArticles(
      GetArticlesParams params);

  Future<Either<Failure, LikeDislikeArticleEntity>> likeDislikeArticle(
      LikeDislikeArticleParams params);
}
