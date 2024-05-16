import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/post_entities/comment_like_dislike_entity.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';

class LikeDislikeCommentUsecase
    extends UseCase<CommentLikeDislikeEntity, LikeDislikeCommentParams> {
  final PostRepository _postRepository;

  LikeDislikeCommentUsecase(this._postRepository);

  @override
  Future<Either<Failure, CommentLikeDislikeEntity>> call(
      LikeDislikeCommentParams params) {
    return _postRepository.likeDislikeComment(params);
  }
}

class LikeDislikeCommentParams {
  final String commentId;

  LikeDislikeCommentParams({required this.commentId});
}
