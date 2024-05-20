import 'package:dartz/dartz.dart';
import 'package:my_sutra/features/domain/entities/chat_entities/chat_entity.dart';

import '../../../core/error/failures.dart';
import '../entities/chat_entities/room_entity.dart';
import '../usecases/chat_usecases/listen_messages_usecase.dart';
import '../usecases/chat_usecases/listen_user_data_usecase.dart';
import '../usecases/chat_usecases/send_message_usecase.dart';
import '../usecases/chat_usecases/set_user_data_usecase.dart';

abstract class ChatRepository {
  Stream<ChatEntity> listenChatData({required ListenMessagesParams data});

  Future<Either<Failure, void>> sendMessage({required SendMessageParams data});

  Stream<RoomUserEntity> listenUserData({required ListenUserDataParams data});

  Future<Either<Failure, void>> setUserData(
      {required SetUserDataParams data});
}
