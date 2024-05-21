import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';

class GetPostDetailUsecase extends UseCase<PostEntity, String> {
  final PostRepository _postRepository;

  GetPostDetailUsecase(this._postRepository);

  @override
  Future<Either<Failure, PostEntity>> call(String params) {
    return _postRepository.getPostDetail(params);
  }
}
