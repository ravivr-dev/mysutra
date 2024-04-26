import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/user_entities/messages_entity.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class GetMessageUseCase extends UseCase<MessagesEntity, GetMessageParams> {
  final UserRepository repo;

  GetMessageUseCase(this.repo);

  @override
  Future<Either<Failure, MessagesEntity>> call(GetMessageParams params) async {
    return await repo.getMessages(
        params.appointmentId, params.pagination, params.limit);
  }
}

class GetMessageParams {
  final String appointmentId;
  final int? pagination;
  final int? limit;

  GetMessageParams({
    required this.appointmentId,
    this.pagination,
    this.limit,
  });
}
