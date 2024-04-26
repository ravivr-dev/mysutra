import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/user_entities/messages_entity.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/clear_messages_use_case.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_message_use_case.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/send_message_use_case.dart';
import 'package:my_sutra/features/domain/entities/user_entities/chat_entity.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendMessageUsecase sendMessageUsecase;
  final GetMessageUseCase getMessageUseCase;
  final ClearMessagesUseCase clearMessagesUseCase;
  ChatCubit(
      {required this.sendMessageUsecase,
      required this.getMessageUseCase,
      required this.clearMessagesUseCase})
      : super(ChatInitial());

  sendMessage(ChatEntity params) async {
    emit(SendMsgLoading());
    final result = await sendMessageUsecase(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(
        SendMessageSuccess(data),
      );
    });
  }

  getChatMessages(GetMessageParams params) async {
    emit(ChatLoading());
    final result = await getMessageUseCase(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(
        GetChatMessagesSuccess(data),
      );
    });
  }

  clearChatMessages(String appointmentId) async {
    emit(ChatLoading());
    final result = await clearMessagesUseCase(appointmentId);

    result.fold((l) => _emitFailure(l), (data) {
      emit(
        ClearMessageSuccess(data),
      );
    });
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
}
