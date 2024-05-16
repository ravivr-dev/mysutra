import 'package:cloud_firestore/cloud_firestore.dart';

class ChatEntity {
  final List<MessageEntity> messages;

  ChatEntity.fromList(List<Map<String, dynamic>> list)
      : messages = list.map((e) => MessageEntity.fromJson(e)).toList();
}

class MessageEntity {
  final String message;
  final DateTime time;
  final String senderId;

  MessageEntity.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        time = (json['time'] as Timestamp).toDate(),
        senderId = json['senderId'];
}
