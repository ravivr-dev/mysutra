import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/create_post_usecase.dart';

class RePostUsecase extends UseCase<String, CreatePostParams> {
  final PostRepository _postRepository;

  RePostUsecase(this._postRepository);

  @override
  Future<Either<Failure, String>> call(CreatePostParams params) {
    return _postRepository.rePost(params);
  }
}
