import 'dart:async';

import 'package:dio/dio.dart';
import 'package:my_sutra/core/utils/endpoint_constants.dart';
import 'package:my_sutra/features/data/model/post_models/comment_like_dislike_model.dart';
import 'package:my_sutra/features/data/model/post_models/comment_model.dart';
import 'package:my_sutra/features/data/model/post_models/post_like_dislike_model.dart';
import 'package:my_sutra/features/data/model/post_models/post_detail_model.dart';
import 'package:my_sutra/features/data/model/post_models/posts_model.dart';
import 'package:my_sutra/features/data/model/post_models/reply_like_dislike_model.dart';
import 'package:my_sutra/features/data/model/success_message_model.dart';
import 'package:retrofit/http.dart';
import 'package:my_sutra/core/extension/custom_ext.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:retrofit/retrofit.dart';

part 'post_client.g.dart';

/// Use below command to generate
/// fvm flutter pub run build_runner build --delete-conflicting-outputs

@RestApi()
abstract class PostRestClient {
  factory PostRestClient(
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
    return _PostRestClient(
      dio,
      baseUrl: Constants.baseUrl,
    );
  }

  @POST(EndPoints.post)
  Future<SuccessMessageModel> createPost(@Body() Map<String, dynamic> data);

  @GET(EndPoints.post)
  Future<PostModel> getPosts(@Queries() Map<String, dynamic> map);

  @PUT(EndPoints.post)
  Future<SuccessMessageModel> editPost(@Queries() Map<String, dynamic> map);

  @POST(EndPoints.postLikeDislike)
  Future<PostLikeDislikeModel> likeDislikePost(
      @Body() Map<String, dynamic> map);

  @GET('${EndPoints.post}/{postId}')
  Future<PostDetailModel> getPostDetail(@Path('postId') String postId);

  @GET(EndPoints.comment)
  Future<CommentModel> getComment(@Queries() Map<String, dynamic> map);

  @POST(EndPoints.comment)
  Future<SuccessMessageModel> postComment(@Body() Map<String, dynamic> map);

  @POST(EndPoints.reply)
  Future<SuccessMessageModel> postReply(@Body() Map<String, dynamic> map);

  @POST(EndPoints.commentLikeDislike)
  Future<CommentLikeDislikeModel> likeDislikeComment(
      @Body() Map<String, dynamic> map);

  @POST(EndPoints.replyLikeDislike)
  Future<ReplyLikeDislikeModel> likeDislikeReply(
      @Body() Map<String, dynamic> map);

  @DELETE('${EndPoints.post}/{postId}')
  Future<SuccessMessageModel> deletePost(@Path('postId') String postId);

  @DELETE('${EndPoints.comment}/{commentId}')
  Future<SuccessMessageModel> deleteComment(
      @Path('commentId') String commentId);

  @DELETE('${EndPoints.reply}/{replyId}')
  Future<SuccessMessageModel> deleteReply(@Path('replyId') String replyId);
}
