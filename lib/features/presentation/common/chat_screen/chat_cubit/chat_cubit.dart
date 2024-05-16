import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/chat_entities/chat_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/messages_entity.dart';
import 'package:my_sutra/features/domain/usecases/chat_usecases/listen_messages_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/clear_messages_use_case.dart';

import '../../../../domain/usecases/chat_usecases/send_message_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChattingState> {
  final SendMessageUseCase sendMessageUseCase;
  final ListenMessagesUseCase listenMessagesUseCase;
  final ClearMessagesUseCase clearMessagesUseCase;

  ChatCubit({
    required this.sendMessageUseCase,
    required this.clearMessagesUseCase,
    required this.listenMessagesUseCase,
  }) : super(ChatInitial());

  clearChatMessages(String appointmentId) async {
    emit(ClearChatLoading());
    final result = await clearMessagesUseCase(appointmentId);

    result.fold((l) => _emitClearChatFailure(l), (data) {
      emit(
        ClearMessageSuccess(data),
      );
    });
  }

  Stream<ChatEntity> listenMessages({required String roomId}) {
    return listenMessagesUseCase.call(ListenMessagesParams(roomId: roomId));
  }

  void sendMessage(SendMessageParams params) async {
    final result = await sendMessageUseCase.call(params);
    result.fold((l) => emit(SendMessageErrorState(l.message)),
        (r) => emit(const SendMessageSuccessState()));
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
