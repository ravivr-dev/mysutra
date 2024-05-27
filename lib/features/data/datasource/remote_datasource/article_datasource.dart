import 'package:dio/dio.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/client/article_client.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/model/article_models/article_detail_model.dart';
import 'package:my_sutra/features/data/model/article_models/articles_model.dart';
import 'package:my_sutra/features/data/model/article_models/like_dislike_article_model.dart';
import 'package:my_sutra/features/data/model/success_message_model.dart';

abstract class ArticleDatasource {
  Future<SuccessMessageModel> createArticle(Map<String, dynamic> map);

  Future<ArticlesModel> getArticles(Map<String, dynamic> map);

  Future<ArticleDetailModel> getArticleDetails(String articleId);

  Future<LikeDislikeArticleModel> likeDislikeArticle(Map<String, dynamic> map);
}

class ArticleDatasourceImpl extends ArticleDatasource {
  final ArticleRestClient client;
  final LocalDataSource localDataSource;

  ArticleDatasourceImpl({required this.client, required this.localDataSource});

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
  Future<SuccessMessageModel> createArticle(Map<String, dynamic> map) async {
    try {
      return await client.createArticle(map).catchError((err) {
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
  Future<ArticlesModel> getArticles(Map<String, dynamic> map) async {
    try {
      return await client.getArticles(map).catchError((err) {
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
  Future<ArticleDetailModel> getArticleDetails(String articleId) async {
    try {
      return await client.getArticleDetails(articleId).catchError((err) {
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
  Future<LikeDislikeArticleModel> likeDislikeArticle(
      Map<String, dynamic> map) async {
    try {
      return await client.likeDislikeArticle(map).catchError((err) {
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
