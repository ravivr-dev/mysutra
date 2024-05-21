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

final class GetPostDetailLoading extends PostsState {}

final class GetPostDetailLoaded extends PostsState {
  final PostEntity post;

  GetPostDetailLoaded({required this.post});
}

final class GetPostDetailError extends PostsState {
  final String error;

  GetPostDetailError({required this.error});
}

final class GetCommentLoading extends PostsState {}

final class GetCommentLoaded extends PostsState {
  final List<CommentEntity> comments;

  GetCommentLoaded({required this.comments});
}

final class GetCommentError extends PostsState {
  final String error;

  GetCommentError({required this.error});
}

final class UploadDocLoading extends PostsState {}

final class UploadDocument extends PostsState {
  final UploadDocModel data;

  UploadDocument(this.data);
}

final class UploadDocumentError extends PostsState {
  final String error;

  UploadDocumentError(this.error);
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
  final PostLikeDislikeEntity likeDislikeEntity;

  LikeDislikePostLoaded({required this.likeDislikeEntity});
}

final class LikeDislikePostError extends PostsState {
  final String error;

  LikeDislikePostError({required this.error});
}

final class NewCommentLoading extends PostsState {}

final class NewCommentLoaded extends PostsState {
  final String message;

  NewCommentLoaded({required this.message});
}

final class NewCommentError extends PostsState {
  final String error;

  NewCommentError({required this.error});
}

final class NewReplyLoading extends PostsState {}

final class NewReplyLoaded extends PostsState {
  final String message;

  NewReplyLoaded({required this.message});
}

final class NewReplyError extends PostsState {
  final String error;

  NewReplyError({required this.error});
}

final class ReportPostLoading extends PostsState {}

final class ReportPostLoaded extends PostsState {
  final String message;

  ReportPostLoaded({required this.message});
}

final class ReportPostError extends PostsState {
  final String error;

  ReportPostError({required this.error});
}

final class RePostLoading extends PostsState {}

final class RePostLoaded extends PostsState {
  final String message;

  RePostLoaded({required this.message});
}

final class RePostError extends PostsState {
  final String error;

  RePostError({required this.error});
}

final class DeletePostLoading extends PostsState {}

final class DeletePostLoaded extends PostsState {
  final String message;

  DeletePostLoaded({required this.message});
}

final class DeletePostError extends PostsState {
  final String error;

  DeletePostError({required this.error});
}

final class EditPostLoading extends PostsState {}

final class EditPostLoaded extends PostsState {
  final String message;

  EditPostLoaded({required this.message});
}

final class EditPostError extends PostsState {
  final String error;

  EditPostError({required this.error});
}
