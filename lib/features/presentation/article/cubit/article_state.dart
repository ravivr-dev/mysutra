part of 'article_cubit.dart';

abstract class ArticleState {}

final class ArticleInitial extends ArticleState {}

final class CreateArticleLoading extends ArticleState {}

final class CreateArticleLoaded extends ArticleState {
  final String message;

  CreateArticleLoaded({required this.message});
}

final class CreateArticleError extends ArticleState {
  final String error;

  CreateArticleError({required this.error});
}

final class GetArticlesLoading extends ArticleState {}

final class GetArticlesLoaded extends ArticleState {
  final List<ArticleEntity> articles;

  GetArticlesLoaded({required this.articles});
}

final class GetArticlesError extends ArticleState {
  final String error;

  GetArticlesError({required this.error});
}

final class LikeDislikeArticleLoading extends ArticleState {}

final class LikeDislikeArticleError extends ArticleState {
  final String error;

  LikeDislikeArticleError({required this.error});
}

final class LikeDislikeArticleLoaded extends ArticleState {
  final String articleId;

  LikeDislikeArticleLoaded({required this.articleId});
}

final class WriteCommentLoading extends ArticleState {}

final class WriteCommentLoaded extends ArticleState {
  final String message;

  WriteCommentLoaded({required this.message});
}

final class WriteCommentError extends ArticleState {
  final String error;

  WriteCommentError({required this.error});
}

final class GetArticleCommentsLoading extends ArticleState {}

final class GetArticleCommentsLoaded extends ArticleState {
  final List<ArticleCommentEntity> articleComments;

  GetArticleCommentsLoaded({required this.articleComments});
}

final class GetArticleCommentsError extends ArticleState {
  final String error;

  GetArticleCommentsError({required this.error});
}

final class DeleteArticleLoading extends ArticleState {}

final class DeleteArticleLoaded extends ArticleState {
  final String mesage;

  DeleteArticleLoaded({required this.mesage});
}

final class DeleteArticleError extends ArticleState {
  final String error;

  DeleteArticleError({required this.error});
}

final class LikeDislikeCommentLoading extends ArticleState {}

final class LikeDislikeCommentLoaded extends ArticleState {
  final String commentId;

  LikeDislikeCommentLoaded({required this.commentId});
}

final class LikeDislikeCommentError extends ArticleState {
  final String error;

  LikeDislikeCommentError({required this.error});
}
