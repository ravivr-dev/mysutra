import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/network/network_info.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/post_datasource.dart';
import 'package:my_sutra/features/data/repositories/post_repo/post_repository_conv.dart';
import 'package:my_sutra/features/domain/entities/post_entities/comment_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/comment_like_dislike_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_like_dislike_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_detail_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/reply_like_dislike_entity.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/create_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/delete_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/edit_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/get_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/get_posts_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/like_dislike_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/like_dislike_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/like_dislike_reply_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/new_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/new_reply_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/report_post_usecase.dart';

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
  Future<Either<Failure, PostLikeDislikeEntity>> likeDislikePost(
      LikeDislikePostParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result =
            await remoteDatasource.likeDislikePost({"postId": params.postId});
        return Right(PostRepoConv.convertPostLikeDislikeModelToEntity(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, PostDetailEntity>> getPostDetail(String postId) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getPostDetail(postId);

        return Right(PostRepoConv.convertPostDetailModelToEntity(result.data));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComment(
      GetCommentParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getComment({
          "postId": params.postId,
          "pagination": params.pagination,
          "limit": params.limit
        });

        return Right(PostRepoConv.convertCommentModelToEntity(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CommentLikeDislikeEntity>> likeDislikeComment(
      LikeDislikeCommentParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource
            .likeDislikeComment({"commentId": params.commentId});

        return Right(
            PostRepoConv.convertCommentLikeDislikeModelToEntity(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ReplyLikeDislikeEntity>> likeDislikeReply(
      LikeDislikeReplyParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource
            .likeDislikeReply({"replyId": params.replyId});

        return Right(PostRepoConv.convertReplyLikeDislikeModelToEntity(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> postComment(NewCommentParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource
            .postComment({"postId": params.postId, "comment": params.comment});

        return Right(result.message ?? "Post Comment Success");
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> postReply(NewReplyParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource
            .postReply({"commentId": params.commentId, "reply": params.reply});

        return Right(result.message ?? "Post Reply Success");
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> reportPost(ReportPostParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.reportPost({
          "postId": params.postId,
          "reportReason": params.reportReason,
          "description": params.description
        });

        return Right(result.message ?? 'Post Report Success');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> rePost(CreatePostParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.createPost({
          "postId": params.postId,
          "content": params.content,
          "mediaUrls": params.mediaUrls.map((e) => e.toJson()).toList(),
          "taggedUserIds": params.taggedUserIds
        });

        return Right(result.message ?? 'Reposted Successfully');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deletePost(DeletePostParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.deletePost(params.postId);
        return Right(result.message ?? 'Deleted Post Successfully');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> editPost(EditPostParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.editPost({
          "postId": params.postId,
          "content": params.content,
          "mediaUrls": params.mediaUrls,
          "taggedUserIds": params.taggedUserIds
        });
        return Right(result.message ?? 'Post Updated Successfully');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
