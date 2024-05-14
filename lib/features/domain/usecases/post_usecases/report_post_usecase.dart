import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';

class ReportPostUsecase extends UseCase<String, ReportPostParams> {
  final PostRepository _postRepository;

  ReportPostUsecase(this._postRepository);

  @override
  Future<Either<Failure, String>> call(ReportPostParams params) {
    return _postRepository.reportPost(params);
  }
}

class ReportPostParams {
  final String postId;
  final String reportReason;
  final String description;

  ReportPostParams(
      {required this.postId,
      required this.reportReason,
      required this.description});
}
