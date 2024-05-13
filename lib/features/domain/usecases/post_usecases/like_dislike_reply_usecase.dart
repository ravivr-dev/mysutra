import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/post_entities/reply_like_dislike_entity.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';

class LikeDislikeReplyUsecase
    extends UseCase<ReplyLikeDislikeEntity, LikeDislikeReplyParams> {
  final PostRepository _postRepository;

  LikeDislikeReplyUsecase(this._postRepository);

  @override
  Future<Either<Failure, ReplyLikeDislikeEntity>> call(
      LikeDislikeReplyParams params) {
    return _postRepository.likeDislikeReply(params);
  }
}

class LikeDislikeReplyParams {
  final String replyId;

  LikeDislikeReplyParams({required this.replyId});
}
