import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/network/network_info.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/post_datasource.dart';
import 'package:my_sutra/features/data/repositories/post_repo/post_repository_conv.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/create_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/get_posts_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/like_dislike_post_usecase.dart';

class PostRepositoryImpl extends PostRepository {
  final LocalDataSource localDataSource;
  final PostDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDatasource,
      required this.networkInfo});

  @override
  Future<Either<Failure, String>> createPost(CreatePostParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.createPost({
          "content": params.content,
          "mediaUrls": params.mediaUrls.map((e) => e.toJson()).toList(),
          "taggedUserIds": params.taggedUserIds
        });

        return Right(result.message ?? 'New Post Created Successfully.');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts(
      GetPostsParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource
            .getPosts({"pagination": params.pagination, "limit": params.limit});

        return Right(PostRepoConv.convertPostsModelToEntity(result.data));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> likeDislikePost(
      LikeDislikePostParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result =
            await remoteDatasource.likeDislikePost({"postId": params.postId});
        return Right(result.message ?? 'Liked/Disliked post Successfully');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
