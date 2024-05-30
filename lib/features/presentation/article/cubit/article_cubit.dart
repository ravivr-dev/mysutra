import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_sutra/features/data/model/user_models/upload_doc_model.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_comment_entity.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_media_urls_entity.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/create_article_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/delete_article_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/edit_article_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/get_article_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/get_article_detail_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/get_articles_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/like_dislike_article_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/like_dislike_article_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/write_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/upload_document_usecase.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  final UploadDocumentUsecase uploadDocumentUsecase;
  final CreateArticleUsecase createArticleUsecase;
  final GetArticlesUsecase getArticlesUsecase;
  final ArticleDetailUsecase getArticleDetailUsecase;
  final LikeDislikeArticleUsecase likeDislikeArticleUsecase;
  final GetArticleCommentUsecase articleCommentUsecase;
  final WriteCommentUsecase writeCommentUsecase;
  final DeleteArticleUsecase deleteArticleUsecase;
  final LikeDislikeArticleCommentUsecase likeDislikeArticleCommentUsecase;
  final EditArticleUsecase editArticleUsecase;

  ArticleCubit({
    required this.uploadDocumentUsecase,
    required this.editArticleUsecase,
    required this.getArticleDetailUsecase,
    required this.likeDislikeArticleCommentUsecase,
    required this.deleteArticleUsecase,
    required this.writeCommentUsecase,
    required this.articleCommentUsecase,
    required this.likeDislikeArticleUsecase,
    required this.createArticleUsecase,
    required this.getArticlesUsecase,
  }) : super(ArticleInitial());

  void uploadDoc(XFile file) async {
    emit(UploadDocLoading());

    final result = await uploadDocumentUsecase.call(File(file.path));

    result.fold(
        (l) => emit(UploadDocError(
            error:
                'There is some error while uploading selected image. TRY AGAIN.')),
        (r) => emit(UploadDocLoaded(data: r)));
  }

  void createPost({
    required String heading,
    required String content,
    required List<ArticleMediaUrlEntity> mediaUrls,
  }) async {
    final result = await createArticleUsecase.call(CreateArticleParams(
      heading: heading,
      content: content,
      mediaUrls: mediaUrls,
    ));
    result.fold((l) => emit(CreateArticleError(error: l.message)),
        (r) => emit(CreateArticleLoaded(message: r)));
  }

  void editArticle(
      {required String articleId,
      required String heading,
      required String content}) async {
    final result = await editArticleUsecase.call(EditArticleParams(
        articleId: articleId, heading: heading, content: content));

    result.fold((l) => emit(EditArticleError(error: l.message)),
        (r) => emit(EditArticleLoaded(message: r)));
  }

  void getArticles({required int pagination, required int limit}) async {
    final result = await getArticlesUsecase
        .call(GetArticlesParams(pagination: pagination, limit: limit));

    result.fold((l) => emit(GetArticlesError(error: l.message)),
        (r) => emit(GetArticlesLoaded(articles: r)));
  }

  void getArticleDetail({required String articleId}) async {
    emit(GetArticleDetailLoading());
    final result = await getArticleDetailUsecase
        .call(ArticleDetailParams(articleId: articleId));

    result.fold((l) => emit(GetArticleDetailError(error: l.message)),
        (r) => emit(GetArticleDetailLoaded(article: r)));
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
