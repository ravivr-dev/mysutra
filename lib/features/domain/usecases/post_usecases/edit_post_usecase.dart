import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/post_entities/media_urls_entity.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';

class EditPostUsecase extends UseCase<String, EditPostParams> {
  final PostRepository _postRepository;

  EditPostUsecase(this._postRepository);

  @override
  Future<Either<Failure, String>> call(EditPostParams params) {
    return _postRepository.editPost(params);
  }
}

class EditPostParams {
  final String postId;
  final String content;
  final List<MediaUrlEntity> mediaUrls;
  final List<String> taggedUserIds;

  EditPostParams(
      {required this.postId,
        required this.content,
        required this.mediaUrls,
        required this.taggedUserIds});
}
