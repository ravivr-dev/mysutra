import 'package:dartz/dartz.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/firebase_datasource.dart';
import 'package:my_sutra/features/domain/entities/chat_entities/chat_entity.dart';
import 'package:my_sutra/features/domain/usecases/chat_usecases/send_message_usecase.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/constants.dart';
import '../../../domain/repositories/chat_repository.dart';
import '../../../domain/usecases/chat_usecases/listen_messages_usecase.dart';

class ChatRepositoryImpl extends ChatRepository {
  final FirebaseDataSource dataSource;
  final NetworkInfo networkInfo;


  ChatRepositoryImpl({required this.networkInfo,required this.dataSource});

  @override
  Stream<ChatEntity> listenChatData({required ListenMessagesParams data}) {
    return dataSource
        .listenChatData(roomId: data.roomId)
        .map((event) => ChatEntity.fromList(event));
  }

  @override
  Future<Either<Failure, void>> sendMessage({required SendMessageParams data}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await dataSource.sendMessage(roomId: data.roomId, data: {
          'senderId': data.senderID,
          'time': data.timeStamp,
          'message': data.message,
        });

        return Right(result);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
