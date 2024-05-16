import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_sutra/features/data/model/user_models/upload_doc_model.dart';
import 'package:my_sutra/features/domain/entities/post_entities/comment_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_like_dislike_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/media_urls_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_detail_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/create_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/get_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/get_post_detail_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/get_posts_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/like_dislike_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/like_dislike_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/like_dislike_reply_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/new_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/new_reply_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/report_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/upload_document_usecase.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final UploadDocumentUsecase uploadDocumentUsecase;
  final CreatePostUsecase createPostUsecase;
  final GetPostsUsecase getPostsUsecase;
  final GetPostDetailUsecase getPostDetailUsecase;
  final GetCommentUsecase getCommentUsecase;
  final LikeDislikePostUsecase likeUnlikePostUsecase;
  final LikeDislikeCommentUsecase likeDislikeCommentUsecase;
  final LikeDislikeReplyUsecase likeDislikeReplyUsecase;
  final NewCommentUsecase newCommentUsecase;
  final NewReplyUsecase newReplyUsecase;
  final ReportPostUsecase reportPostUsecase;

  PostsCubit(
      {required this.reportPostUsecase,
      required this.newCommentUsecase,
      required this.newReplyUsecase,
      required this.likeDislikeCommentUsecase,
      required this.likeDislikeReplyUsecase,
      required this.getPostDetailUsecase,
      required this.getCommentUsecase,
      required this.likeUnlikePostUsecase,
      required this.getPostsUsecase,
      required this.createPostUsecase,
      required this.uploadDocumentUsecase})
      : super(PostsInitial());

  void uploadDoc(XFile file) async {
    emit(UploadDocLoading());

    final result = await uploadDocumentUsecase.call(File(file.path));

    result.fold(
        (l) => emit(UploadDocumentError(
            'There is some error while uploading selected image. TRY AGAIN.')),
        (r) => emit(UploadDocument(r)));
  }

  void createPost(
      {required String content,
      required List<MediaUrlEntity> mediaUrls,
      required List<String> taggedUserIds}) async {
    emit(CreatePostLoading());
    final result = await createPostUsecase.call(CreatePostParams(
        content: content, mediaUrls: mediaUrls, taggedUserIds: taggedUserIds));

    result.fold((l) => emit(CreatePostError(error: l.message)),
        (r) => emit(CreatePostLoaded(message: r)));
  }

  void getPosts({required int pagination, required int limit}) async {
    emit(GetPostsLoading());
    final result = await getPostsUsecase
        .call(GetPostsParams(pagination: pagination, limit: limit));

    result.fold((l) => emit(GetPostsError(error: l.message)),
        (r) => emit(GetPostsLoaded(posts: r)));
  }

  void getPostDetail({required String postId}) async {
    emit(GetPostDetailLoading());
    final result = await getPostDetailUsecase.call(postId);

    result.fold((l) => emit(GetPostDetailError(error: l.message)),
        (r) => emit(GetPostDetailLoaded(post: r)));
  }

  void getComments(
      {required String postId,
      required int pagination,
      required int limit}) async {
    emit(GetCommentLoading());
    final result = await getCommentUsecase.call(
        GetCommentParams(postId: postId, pagination: pagination, limit: limit));

    result.fold((l) => emit(GetCommentError(error: l.message)),
        (r) => emit(GetCommentLoaded(comments: r)));
  }

  void likeDislikePost({required String postId}) async {
    final result =
        await likeUnlikePostUsecase.call(LikeDislikePostParams(postId: postId));

    result.fold((l) => emit(LikeDislikePostError(error: l.message)),
        (r) => emit(LikeDislikePostLoaded(likeDislikeEntity: r)));
  }

  void newComment({required String postId, required String comment}) async {
    final result = await newCommentUsecase
        .call(NewCommentParams(postId: postId, comment: comment));

    result.fold((l) => emit(NewCommentError(error: l.message)),
        (r) => emit(NewCommentLoaded(message: r)));
  }

  void newReply({required String commentId, required String reply}) async {
    final result = await newReplyUsecase
        .call(NewReplyParams(commentId: commentId, reply: reply));

    result.fold((l) => emit(NewReplyError(error: l.message)),
        (r) => emit(NewReplyLoaded(message: r)));
  }

  void reportPost(
      {required String postId,
      required String reportReason,
      required String description}) async {
    final result = await reportPostUsecase.call(ReportPostParams(
        postId: postId, reportReason: reportReason, description: description));

    result.fold((l) => emit(ReportPostError(error: l.message)),
        (r) => emit(ReportPostLoaded(message: r)));
  }
}
