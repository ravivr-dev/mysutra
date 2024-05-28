import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_comment_entity.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/create_article_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/delete_article_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/get_article_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/get_articles_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/like_dislike_article_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/like_dislike_article_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/write_comment_usecase.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  final CreateArticleUsecase createArticleUsecase;
  final GetArticlesUsecase getArticlesUsecase;
  final LikeDislikeArticleUsecase likeDislikeArticleUsecase;
  final GetArticleCommentUsecase articleCommentUsecase;
  final WriteCommentUsecase writeCommentUsecase;
  final DeleteArticleUsecase deleteArticleUsecase;
  final LikeDislikeArticleCommentUsecase likeDislikeArticleCommentUsecase;

  ArticleCubit({
    required this.likeDislikeArticleCommentUsecase,
    required this.deleteArticleUsecase,
    required this.writeCommentUsecase,
    required this.articleCommentUsecase,
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

  void getArticleComments(
      {required String articleId,
      required int pagination,
      required int limit}) async {
    final result = await articleCommentUsecase.call(ArticleCommentParams(
        articleId: articleId, pagination: pagination, limit: limit));

    result.fold((l) => emit(GetArticleCommentsError(error: l.message)),
        (r) => emit(GetArticleCommentsLoaded(articleComments: r)));
  }

  void writeComment(
      {required String articleId, required String comment}) async {
    final result = await writeCommentUsecase
        .call(WriteCommentParams(articleId: articleId, comment: comment));

    result.fold((l) => emit(WriteCommentError(error: l.message)),
        (r) => emit(WriteCommentLoaded(message: r)));
  }

  void deleteArticle({required String articleId}) async {
    final result = await deleteArticleUsecase.call(articleId);

    result.fold((l) => emit(DeleteArticleError(error: l.message)),
        (r) => emit(DeleteArticleLoaded(mesage: r)));
  }

  void likeDislikeComment({required String commentId}) async {
    final result = await likeDislikeArticleCommentUsecase
        .call(LikeDislikeArticleCommentParams(commentId: commentId));

    result.fold((l) => emit(LikeDislikeArticleError(error: l.message)),
        (r) => emit(LikeDislikeCommentLoaded(commentId: commentId)));
  }
}
