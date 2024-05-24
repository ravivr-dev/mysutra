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

final class SendMsgLoadingState extends ChattingState {}

final class SendMessageSuccessState extends ChattingState {
  const SendMessageSuccessState();
}

final class SendMessageErrorState extends ChattingState {
  final String message;

  const SendMessageErrorState(this.message);
}

final class ClearMessageSuccess extends ChattingState {
  final String message;

  const ClearMessageSuccess(this.message);
}

final class GetChatMessagesSuccess extends ChattingState {
  final MessagesEntity messageList;

  const GetChatMessagesSuccess(this.messageList);
}

final class SetOnlineStatusSuccessState extends ChattingState {
  const SetOnlineStatusSuccessState();
}

final class SetOnlineStatusErrorState extends ChattingState {
  final String message;

  const SetOnlineStatusErrorState(this.message);
}

final class DownloadPdfErrorState extends ChattingState {
  final String message;

  const DownloadPdfErrorState(this.message);
}

final class DownloadPdfSuccessState extends ChattingState {
  final String filePath;

  const DownloadPdfSuccessState(this.filePath);
}
