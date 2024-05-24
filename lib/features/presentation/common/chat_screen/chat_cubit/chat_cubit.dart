import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/chat_entities/chat_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/messages_entity.dart';
import 'package:my_sutra/features/domain/usecases/chat_usecases/listen_messages_usecase.dart';
import 'package:my_sutra/features/domain/usecases/chat_usecases/set_user_data_usecase.dart';

import '../../../../domain/entities/chat_entities/room_entity.dart';
import '../../../../domain/usecases/chat_usecases/listen_user_data_usecase.dart';
import '../../../../domain/usecases/chat_usecases/send_message_usecase.dart';
import '../../../../domain/usecases/user_usecases/download_pdf_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChattingState> {
  final SendMessageUseCase sendMessageUseCase;
  final ListenMessagesUseCase listenMessagesUseCase;
  final ListenUserDataUseCase listenRoomUseCase;
  final SetUserDataUseCase setUserDataUseCase;
  final DownloadPdfUseCase downloadPdfUseCase;

  ChatCubit({
    required this.sendMessageUseCase,
    required this.listenMessagesUseCase,
    required this.listenRoomUseCase,
    required this.setUserDataUseCase,
    required this.downloadPdfUseCase,
  }) : super(ChatInitial());

  clearChatMessages(String appointmentId) async {
    // emit(ClearChatLoading());
    // final result = await clearMessagesUseCase(appointmentId);
    //
    // result.fold((l) => _emitClearChatFailure(l), (data) {
    //   emit(
    //     ClearMessageSuccess(data),
    //   );
    // });
  }

  Stream<ChatEntity> listenMessages({required String roomId}) {
    return listenMessagesUseCase.call(ListenMessagesParams(roomId: roomId));
  }

  Stream<RoomUserEntity> listenUserData({required String userId}) {
    return listenRoomUseCase.call(ListenUserDataParams(userId: userId));
  }

  void sendMessage(SendMessageParams params) async {
    final result = await sendMessageUseCase.call(params);
    result.fold((l) => emit(SendMessageErrorState(l.message)),
        (r) => emit(const SendMessageSuccessState()));
  }

  void setUserData(SetUserDataParams params) async {
    final result = await setUserDataUseCase.call(params);
    result.fold((l) => emit(SetOnlineStatusErrorState(l.message)),
        (r) => emit(const SetOnlineStatusSuccessState()));
  }

  void downloadPdf(String url) async {
    final result = await downloadPdfUseCase.call(DownloadPdfParams(url: url));
    result.fold((l) => emit(DownloadPdfErrorState(l.message)),
        (r) => emit(DownloadPdfSuccessState(r)));
  }

  FutureOr<void> _emitFailure(
    Failure failure,
  ) async {
    if (failure is ServerFailure) {
      emit(ChatError(failure.message));
    } else if (failure is CacheFailure) {
      emit(ChatError(failure.message));
    } else {
      emit(ChatError(failure.message));
    }
  }

  FutureOr<void> _emitClearChatFailure(
    Failure failure,
  ) async {
    if (failure is ServerFailure) {
      emit(ClearChatErrorState(failure.message));
    } else if (failure is CacheFailure) {
      emit(ClearChatErrorState(failure.message));
    } else {
      emit(ClearChatErrorState(failure.message));
    }
  }
}
