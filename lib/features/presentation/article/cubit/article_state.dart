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
