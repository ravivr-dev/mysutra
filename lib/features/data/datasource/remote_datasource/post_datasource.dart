import 'package:dio/dio.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/client/post_client.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/model/post_models/like_dislike_model.dart';
import 'package:my_sutra/features/data/model/post_models/posts_model.dart';
import 'package:my_sutra/features/data/model/success_message_model.dart';

abstract class PostDatasource {
  Future<SuccessMessageModel> createPost(Map<String, dynamic> map);

  Future<PostModel> getPosts(Map<String, dynamic> map);

  Future<SuccessMessageModel> editPost(Map<String, dynamic> map);

  Future<LikeDislikeModel> likeDislikePost(Map<String, dynamic> map);
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
      return await client.newPost(map).catchError((err) {
        _processDio(err);
      }
      );
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
  Future<LikeDislikeModel> likeDislikePost(Map<String, dynamic> map) {
    try {
      return client.likeDislikePost(map).catchError((err) {
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
