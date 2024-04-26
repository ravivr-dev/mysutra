class MessagesEntity {
  String? message;
  int? count;
  List<MessageItemEntity>? chatMessages;

  MessagesEntity({this.message, this.count, this.chatMessages});
}

class MessageItemEntity {
  String? id;
  String? connectionId;
  SentByEntity? sender;
  SentToEntity? receiver;
  String? messageType;
  List<String>? mediaUrl;
  String? message;
  String? createdAt;
  String? updatedAt;

  MessageItemEntity(
      {this.id,
      this.connectionId,
      this.sender,
      this.receiver,
      this.messageType,
      this.mediaUrl,
      this.message,
      this.createdAt,
      this.updatedAt});
}

class SentByEntity {
  String? senderId;
  String? profilePic;
  String? fullName;

  SentByEntity({this.senderId, this.profilePic, this.fullName});
}

class SentToEntity {
  String? receiverId;
  String? profilePic;
  String? fullName;

  SentToEntity({this.receiverId, this.profilePic, this.fullName});
}
