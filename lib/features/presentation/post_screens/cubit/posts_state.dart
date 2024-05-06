part of 'posts_cubit.dart';

abstract class PostsState {}

final class PostsInitial extends PostsState {}

final class UploadDocLoading extends PostsState {}

final class UploadDocument extends PostsState {
  final UploadDocModel data;

  UploadDocument(this.data);
}

final class UploadDocumentError extends PostsState {
  final String message;

  UploadDocumentError(this.message);
}
