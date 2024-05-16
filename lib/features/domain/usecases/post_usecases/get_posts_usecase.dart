import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';

class GetPostsUsecase extends UseCase<List<PostEntity>, GetPostsParams> {
  final PostRepository _postRepository;

  GetPostsUsecase(this._postRepository);

  @override
  Future<Either<Failure, List<PostEntity>>> call(GetPostsParams params) {
    return _postRepository.getPosts(params);
  }
}

class GetPostsParams {
  final int pagination;
  final int limit;

  GetPostsParams({required this.pagination, required this.limit});
}
