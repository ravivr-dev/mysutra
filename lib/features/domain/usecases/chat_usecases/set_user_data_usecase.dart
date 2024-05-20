import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_sutra/features/domain/repositories/chat_repository.dart';

import '../../../../core/error/failures.dart';

class SetUserDataUseCase {
  final ChatRepository _repository;

  SetUserDataUseCase(this._repository);

  Future<Either<Failure, void>> call(SetUserDataParams params) {
    return _repository.setUserData(data: params);
  }
}

class SetUserDataParams {
  final String userId;
  final Timestamp lastOnlineAt;
  final bool isOnline;

  const SetUserDataParams({
    required this.userId,
    required this.lastOnlineAt,
    required this.isOnline,
  });
}
