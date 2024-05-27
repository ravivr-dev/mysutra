import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/create_article_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/get_articles_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/like_dislike_article_usecase.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  final CreateArticleUsecase createArticleUsecase;
  final GetArticlesUsecase getArticlesUsecase;
  final LikeDislikeArticleUsecase likeDislikeArticleUsecase;

  ArticleCubit({
    required this.likeDislikeArticleUsecase,
    required this.createArticleUsecase,
    required this.getArticlesUsecase,
  }) : super(ArticleInitial());

  void createPost({
    required String heading,
    required String content,
  }) async {
    final result = await createArticleUsecase.call(CreateArticleParams(
      heading: heading,
      content: content,
    ));
    result.fold((l) => emit(CreateArticleError(error: l.message)),
        (r) => emit(CreateArticleLoaded(message: r)));
  }

  void getArticles({required int pagination, required int limit}) async {
    final result = await getArticlesUsecase
        .call(GetArticlesParams(pagination: pagination, limit: limit));

    result.fold((l) => emit(GetArticlesError(error: l.message)),
        (r) => emit(GetArticlesLoaded(articles: r)));
  }

  void likeDislikeArticle({required String articleId}) async {
    final result = await likeDislikeArticleUsecase
        .call(LikeDislikeArticleParams(articleId: articleId));

    result.fold((l) => emit(LikeDislikeArticleError(error: l.message)),
        (r) => emit(LikeDislikeArticleLoaded(articleId: r.articleId!)));
  }
}
