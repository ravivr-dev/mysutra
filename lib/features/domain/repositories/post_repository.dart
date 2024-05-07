import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/create_post_usecase.dart';

abstract class PostRepository {
  Future<Either<Failure, String>> createPost(
      CreatePostParams params);
}
