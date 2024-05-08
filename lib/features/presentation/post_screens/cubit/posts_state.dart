part of 'posts_cubit.dart';

abstract class PostsState {}

final class PostsInitial extends PostsState {}

final class GetPostsLoading extends PostsState {}

final class GetPostsLoaded extends PostsState {
  final List<PostEntity> posts;

  GetPostsLoaded({required this.posts});
}

final class GetPostsError extends PostsState {
  final String error;

  GetPostsError({required this.error});
}

final class UploadDocLoading extends PostsState {}

final class UploadDocument extends PostsState {
  final UploadDocModel data;

  UploadDocument(this.data);
}

final class UploadDocumentError extends PostsState {
  final String message;

  UploadDocumentError(this.message);
}

final class CreatePostLoading extends PostsState {}

final class CreatePostLoaded extends PostsState {
  final String message;

  CreatePostLoaded({required this.message});
}

final class CreatePostError extends PostsState {
  final String error;

  CreatePostError({required this.error});
}

final class LikeDislikePostLoading extends PostsState {}

final class LikeDislikePostLoaded extends PostsState {
  final LikeDislikeEntity likeDislikeEntity;

  LikeDislikePostLoaded({required this.likeDislikeEntity});
}

final class LikeDislikePostError extends PostsState {
  final String error;

  LikeDislikePostError({required this.error});
}
