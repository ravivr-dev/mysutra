import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/post_entities/media_urls_entity.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';

class DeletePostUsecase extends UseCase<String, DeletePostParams> {
  final PostRepository _postRepository;

  DeletePostUsecase(this._postRepository);

  @override
  Future<Either<Failure, String>> call(DeletePostParams params) {
    return _postRepository.deletePost(params);
  }
}

class DeletePostParams {
  final String postId;

  DeletePostParams({
    required this.postId,
  });
}
