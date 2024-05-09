import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/post_entities/media_urls_entity.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';

class CreatePostUsecase extends UseCase<String, CreatePostParams> {
  final PostRepository _postRepository;

  CreatePostUsecase(this._postRepository);

  @override
  Future<Either<Failure, String>> call(CreatePostParams params) {
    return _postRepository.createPost(params);
  }
}

class CreatePostParams {
  final String content;
  final List<MediaUrlEntity> mediaUrls;
  final List<String> taggedUserIds;

  CreatePostParams(
      {required this.content,
      required this.mediaUrls,
      required this.taggedUserIds});
}
