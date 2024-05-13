import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/post_entities/comment_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/comment_like_dislike_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_like_dislike_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_detail_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/reply_like_dislike_entity.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/create_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/get_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/get_posts_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/like_dislike_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/like_dislike_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/like_dislike_reply_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/new_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/new_reply_usecase.dart';

abstract class PostRepository {
  Future<Either<Failure, String>> createPost(CreatePostParams params);

  Future<Either<Failure, List<PostEntity>>> getPosts(GetPostsParams params);

  Future<Either<Failure, PostLikeDislikeEntity>> likeDislikePost(
      LikeDislikePostParams params);

  Future<Either<Failure, PostDetailEntity>> getPostDetail(String postId);

  Future<Either<Failure, List<CommentEntity>>> getComment(
      GetCommentParams params);

  Future<Either<Failure, String>> postComment(NewCommentParams params);

  Future<Either<Failure, String>> postReply(NewReplyParams params);

  Future<Either<Failure, CommentLikeDislikeEntity>> likeDislikeComment(
      LikeDislikeCommentParams params);

  Future<Either<Failure, ReplyLikeDislikeEntity>> likeDislikeReply(
      LikeDislikeReplyParams params);
}
