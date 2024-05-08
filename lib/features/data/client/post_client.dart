import 'package:dio/dio.dart';
import 'package:my_sutra/core/utils/endpoint_constants.dart';
import 'package:my_sutra/features/data/model/post_models/like_dislike_model.dart';
import 'package:my_sutra/features/data/model/post_models/posts_model.dart';
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
  Future<SuccessMessageModel> newPost(@Body() Map<String, dynamic> data);

  @GET(EndPoints.post)
  Future<PostModel> getPosts(@Queries() Map<String, dynamic> map);

  @PUT(EndPoints.post)
  Future<SuccessMessageModel> editPost(@Queries() Map<String, dynamic> map);

  @POST(EndPoints.postLikeDislike)
  Future<LikeDislikeModel> likeDislikePost(@Body() Map<String, dynamic> map);
}
