import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/post_entities/comment_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/like_dislike_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_detail_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/create_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/get_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/get_posts_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/like_dislike_post_usecase.dart';

abstract class PostRepository {
  Future<Either<Failure, String>> createPost(CreatePostParams params);

  Future<Either<Failure, List<PostEntity>>> getPosts(GetPostsParams params);

  Future<Either<Failure, LikeDislikeEntity>> likeDislikePost(
      LikeDislikePostParams params);

  Future<Either<Failure, PostDetailEntity>> getPostDetail(String postId);

  Future<Either<Failure, List<CommentEntity>>> getComment(
      GetCommentParams params);
}
