import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_sutra/features/data/model/user_models/upload_doc_model.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/create_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/get_posts_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/like_dislike_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/upload_document_usecase.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final UploadDocumentUsecase uploadDocumentUsecase;
  final CreatePostUsecase createPostUsecase;
  final GetPostsUsecase getPostsUsecase;
  final LikeDislikePostUsecase likeUnlikeUsecase;

  PostsCubit(
      {required this.likeUnlikeUsecase,
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
    final result = await createPostUsecase.call(CreatePostParams(
        content: content, mediaUrls: mediaUrls, taggedUserIds: taggedUserIds));

    result.fold((l) => emit(CreatePostError(error: l.message)),
        (r) => emit(CreatePostLoaded(message: r)));
  }

  void getPosts({required int pagination, required int limit}) async {
    final result = await getPostsUsecase
        .call(GetPostsParams(pagination: pagination, limit: limit));

    result.fold((l) => emit(GetPostsError(error: l.message)),
        (r) => emit(GetPostsLoaded(posts: r)));
  }

  void likeDislikePost({required String postId}) async {
    final result =
        await likeUnlikeUsecase.call(LikeDislikePostParams(postId: postId));

    result.fold((l) => emit(LikeDislikePostError(error: l.message)),
        (r) => emit(LikeDislikePostLoaded(message: r)));
  }
}
