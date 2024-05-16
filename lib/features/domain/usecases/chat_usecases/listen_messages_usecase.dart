import 'package:my_sutra/features/domain/repositories/chat_repository.dart';

import '../../entities/chat_entities/chat_entity.dart';

class ListenMessagesUseCase {
  final ChatRepository _repository;

  ListenMessagesUseCase(this._repository);

  Stream<ChatEntity> call(ListenMessagesParams params) {
    return _repository.listenChatData(data: params);
  }
}

class ListenMessagesParams {
  final String roomId;

  const ListenMessagesParams({required this.roomId});
}
