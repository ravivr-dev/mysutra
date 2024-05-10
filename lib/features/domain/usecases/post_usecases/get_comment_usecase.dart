import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/post_entities/comment_entity.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';

class GetCommentUsecase extends UseCase<List<CommentEntity>, GetCommentParams> {
  final PostRepository _postRepository;

  GetCommentUsecase(this._postRepository);

  @override
  Future<Either<Failure, List<CommentEntity>>> call(GetCommentParams params) {
    return _postRepository.getComment(params);
  }
}

class GetCommentParams {
  final String postId;
  final int pagination;
  final int limit;

  GetCommentParams(
      {required this.postId, required this.pagination, required this.limit});
}
