part of 'chat_cubit.dart';

class ChattingState extends Equatable {
  const ChattingState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChattingState {}

final class ChatError extends ChattingState {
  final String error;

  const ChatError(this.error);
}

final class ChatLoading extends ChattingState {}

final class ClearChatLoading extends ChattingState {}

final class ClearChatErrorState extends ChattingState {
  final String error;

  const ClearChatErrorState(this.error);
}

final class SendMsgLoading extends ChattingState {}

final class SendMessageSuccess extends ChattingState {
  final String message;

  const SendMessageSuccess(this.message);
}

final class ClearMessageSuccess extends ChattingState {
  final String message;

  const ClearMessageSuccess(this.message);
}

final class GetChatMessagesSuccess extends ChattingState {
  final MessagesEntity messageList;

  const GetChatMessagesSuccess(this.messageList);
}
