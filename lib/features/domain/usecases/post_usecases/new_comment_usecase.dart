import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';

class NewCommentUsecase extends UseCase<String, NewCommentParams> {
  final PostRepository _postRepository;

  NewCommentUsecase(this._postRepository);

  @override
  Future<Either<Failure, String>> call(NewCommentParams params) {
    return _postRepository.postComment(params);
  }
}

class NewCommentParams {
  final String postId;
  final String comment;

  NewCommentParams({required this.postId, required this.comment});
}
