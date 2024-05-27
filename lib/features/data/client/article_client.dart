import 'dart:async';

import 'package:dio/dio.dart';
import 'package:my_sutra/core/utils/endpoint_constants.dart';
import 'package:my_sutra/features/data/model/article_models/article_comment_model.dart';
import 'package:my_sutra/features/data/model/article_models/article_detail_model.dart';
import 'package:my_sutra/features/data/model/article_models/articles_model.dart';
import 'package:my_sutra/features/data/model/article_models/like_dislike_article_model.dart';
import 'package:my_sutra/features/data/model/success_message_model.dart';
import 'package:retrofit/http.dart';
import 'package:my_sutra/core/extension/custom_ext.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:retrofit/retrofit.dart';

part 'article_client.g.dart';

/// Use below command to generate
/// fvm flutter pub run build_runner build --delete-conflicting-outputs

@RestApi()
abstract class ArticleRestClient {
  factory ArticleRestClient(
    final Dio dio,
    final LocalDataSource localDataSource,
  ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.addRequestOptions(localDataSource);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          e.printErrorPath();
          return handler.next(e);
        },
      ),
    );
    return _ArticleRestClient(
      dio,
      baseUrl: Constants.baseUrl,
    );
  }

  @POST(EndPoints.article)
  Future<SuccessMessageModel> createArticle(@Body() Map<String, dynamic> map);

  @PUT(EndPoints.article)
  Future<SuccessMessageModel> editArticle(@Body() Map<String, dynamic> map);

  @GET(EndPoints.article)
  Future<ArticlesModel> getArticles(@Queries() Map<String, dynamic> map);

  @POST(EndPoints.likeDislikeArticle)
  Future<LikeDislikeArticleModel> likeDislikeArticle(
      @Body() Map<String, dynamic> map);

  @PATCH(EndPoints.reportArticle)
  Future<SuccessMessageModel> reportArticle(@Body() Map<String, dynamic> map);

  @GET('${EndPoints.article}/{articleId}')
  Future<ArticleDetailModel> getArticleDetails(
      @Path('articleId') String articleId);

  @DELETE('${EndPoints.article}/{articleId}')
  Future<SuccessMessageModel> deleteArticle(
      @Path('articleId') String articleId);

  @POST(EndPoints.articleComment)
  Future<SuccessMessageModel> articleComment(@Body() Map<String, dynamic> map);

  @GET('${EndPoints.article}/{articleId}/${EndPoints.comment}')
  Future<ArticleCommentModel> getArticleComments(
      @Path('articleId') String articleId, @Queries() Map<String, dynamic> map);


  // todo: change model
  @POST(EndPoints.likeDislikeArticleComment)
  Future<SuccessMessageModel> likeDislikeArticleComment(
      @Body() Map<String, dynamic> map);

  @DELETE('${EndPoints.articleComment}/{commentId}')
  Future<SuccessMessageModel> deleteArticleComment(
      @Path('commentId') String commentId);

  @POST(EndPoints.articleReply)
  Future<SuccessMessageModel> articleReply(@Body() Map<String, dynamic> map);

  @POST(EndPoints.likeDislikeArticleReply)
  Future<SuccessMessageModel> likeDislikeArticleReply(
      @Body() Map<String, dynamic> map);

  @DELETE('${EndPoints.articleReply}/{replyId}')
  Future<SuccessMessageModel> deleteArticleReply(
      @Path('replyId') String replyId);
}
