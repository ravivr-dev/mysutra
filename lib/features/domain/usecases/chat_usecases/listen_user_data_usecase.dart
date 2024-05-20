import 'package:my_sutra/features/domain/repositories/chat_repository.dart';

import '../../entities/chat_entities/room_entity.dart';

class ListenUserDataUseCase {
  final ChatRepository _repository;

  ListenUserDataUseCase(this._repository);

  Stream<RoomUserEntity> call(ListenUserDataParams params) {
    return _repository.listenUserData(data: params);
  }
}

class ListenUserDataParams {
  final String userId;


  const ListenUserDataParams({required this.userId});
}
