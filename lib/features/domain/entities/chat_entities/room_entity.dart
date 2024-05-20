import 'package:cloud_firestore/cloud_firestore.dart';

class RoomUserEntity {
  final bool isOnline;
  final DateTime? lastOnlineAt;

  RoomUserEntity.fromJson(Map<String, dynamic> json)
      : isOnline = json['isOnline'] ?? false,
        lastOnlineAt = (json['lastOnlineAt'] as Timestamp?)?.toDate();
}
