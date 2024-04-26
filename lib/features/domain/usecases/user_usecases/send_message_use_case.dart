import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/user_entities/chat_entity.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class SendMessageUsecase extends UseCase<String, ChatEntity> {
  final UserRepository repo;

  SendMessageUsecase(this.repo);

  @override
  Future<Either<Failure, String>> call(ChatEntity params) async {
    return await repo.sendMessage(params);
  }
}
