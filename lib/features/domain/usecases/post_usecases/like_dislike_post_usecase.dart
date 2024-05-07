import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';

class LikeDislikePostUsecase extends UseCase<String, LikeDislikePostParams> {
  final PostRepository _postRepository;

  LikeDislikePostUsecase(this._postRepository);

  @override
  Future<Either<Failure, String>> call(LikeDislikePostParams params) {
    return _postRepository.likeDislikePost(params);
  }
}

class LikeDislikePostParams {
  final String postId;

  LikeDislikePostParams({required this.postId});
}
