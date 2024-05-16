import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/client/post_client.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/model/post_models/comment_like_dislike_model.dart';
import 'package:my_sutra/features/data/model/post_models/comment_model.dart';
import 'package:my_sutra/features/data/model/post_models/post_like_dislike_model.dart';
import 'package:my_sutra/features/data/model/post_models/post_detail_model.dart';
import 'package:my_sutra/features/data/model/post_models/posts_model.dart';
import 'package:my_sutra/features/data/model/post_models/reply_like_dislike_model.dart';
import 'package:my_sutra/features/data/model/success_message_model.dart';

abstract class PostDatasource {
  Future<SuccessMessageModel> createPost(Map<String, dynamic> map);

  Future<PostModel> getPosts(Map<String, dynamic> map);

  Future<SuccessMessageModel> editPost(Map<String, dynamic> map);

  Future<PostLikeDislikeModel> likeDislikePost(Map<String, dynamic> map);

  Future<PostDetailModel> getPostDetail(String postId);

  Future<CommentModel> getComment(Map<String, dynamic> map);

  Future<SuccessMessageModel> postComment(Map<String, dynamic> map);

  Future<SuccessMessageModel> postReply(Map<String, dynamic> map);

  Future<CommentLikeDislikeModel> likeDislikeComment(Map<String, dynamic> map);

  Future<ReplyLikeDislikeModel> likeDislikeReply(Map<String, dynamic> map);

  Future<SuccessMessageModel> deletePost(String postId);

  Future<SuccessMessageModel> deleteComment(String commentId);

  Future<SuccessMessageModel> deleteReply(String replyId);

  Future<SuccessMessageModel> reportPost(Map<String, dynamic> map);
}

class PostDatasourceImpl extends PostDatasource {
  final PostRestClient client;
  final LocalDataSource localDataSource;

  PostDatasourceImpl({required this.client, required this.localDataSource});

  void _processDio(err) {
    if (err is DioException) {
      throw ServerException(
        message: err.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } else {
      throw ServerException(message: Constants.errorUnknown);
    }
  }

  @override
  Future<SuccessMessageModel> createPost(Map<String, dynamic> map) async {
    try {
      return await client.createPost(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              validateAuthentication: true, localDataSource: localDataSource));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> editPost(Map<String, dynamic> map) async {
    try {
      return await client.editPost(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              localDataSource: localDataSource, validateAuthentication: true));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<PostModel> getPosts(Map<String, dynamic> map) async {
    try {
      return await client.getPosts(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              localDataSource: localDataSource, validateAuthentication: true));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<PostLikeDislikeModel> likeDislikePost(Map<String, dynamic> map) async {
    try {
      return await client.likeDislikePost(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              localDataSource: localDataSource, validateAuthentication: true));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<PostDetailModel> getPostDetail(String postId) async {
    try {
      return await client.getPostDetail(postId).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              localDataSource: localDataSource, validateAuthentication: true));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<CommentModel> getComment(Map<String, dynamic> map) async {
    try {
      return await client.getComment(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              localDataSource: localDataSource, validateAuthentication: true));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> postComment(Map<String, dynamic> map) async {
    try {
      return await client.postComment(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              localDataSource: localDataSource, validateAuthentication: true));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> postReply(Map<String, dynamic> map) async {
    try {
      return await client.postReply(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              localDataSource: localDataSource, validateAuthentication: true));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<CommentLikeDislikeModel> likeDislikeComment(
      Map<String, dynamic> map) async {
    try {
      return await client.likeDislikeComment(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              localDataSource: localDataSource, validateAuthentication: true));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ReplyLikeDislikeModel> likeDislikeReply(
      Map<String, dynamic> map) async {
    try {
      return await client.likeDislikeReply(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              localDataSource: localDataSource, validateAuthentication: true));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> deleteComment(String commentId) async {
    try {
      return await client.deleteComment(commentId).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              localDataSource: localDataSource, validateAuthentication: true));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> deletePost(String postId) async {
    try {
      return await client.deletePost(postId).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              localDataSource: localDataSource, validateAuthentication: true));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> deleteReply(String replyId) async {
    try {
      return await client.deleteReply(replyId).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              localDataSource: localDataSource, validateAuthentication: true));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> reportPost(Map<String, dynamic> map) {
    try {
      return client.reportPost(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              localDataSource: localDataSource, validateAuthentication: true));
    } on Exception {
      rethrow;
    }
  }
}
