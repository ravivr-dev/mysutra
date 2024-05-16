import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';

class NewReplyUsecase extends UseCase<String, NewReplyParams> {
  final PostRepository _postRepository;

  NewReplyUsecase(this._postRepository);

  @override
  Future<Either<Failure, String>> call(NewReplyParams params) {
    return _postRepository.postReply(params);
  }
}

class NewReplyParams {
  final String commentId;
  final String reply;

  NewReplyParams({required this.commentId, required this.reply});
}
