part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatError extends ChatState {
  final String error;

  const ChatError(this.error);
}

final class ChatLoading extends ChatState {}

final class ClearChatLoading extends ChatState {}
final class SendMsgLoading extends ChatState {}

final class SendMessageSuccess extends ChatState {
  final String message;

  const SendMessageSuccess(this.message);
}

final class ClearMessageSuccess extends ChatState {
  final String message;

  const ClearMessageSuccess(this.message);
}

final class GetChatMessagesSuccess extends ChatState {
  final MessagesEntity messageList;

  const GetChatMessagesSuccess(this.messageList);
}
