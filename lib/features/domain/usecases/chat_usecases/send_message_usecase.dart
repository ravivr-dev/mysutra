import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_sutra/features/domain/repositories/chat_repository.dart';

import '../../../../core/error/failures.dart';

class SendMessageUseCase {
  final ChatRepository _repository;

  SendMessageUseCase(this._repository);

  Future<Either<Failure, void>> call(SendMessageParams params) {
    return _repository.sendMessage(data: params);
  }
}

class SendMessageParams {
  final String roomId;
  final String message;
  final String senderID;
  final Timestamp timeStamp;
  final bool? isImage;

  const SendMessageParams({
    required this.senderID,
    required this.timeStamp,
    required this.roomId,
    required this.message,
    this.isImage,
  });
}
