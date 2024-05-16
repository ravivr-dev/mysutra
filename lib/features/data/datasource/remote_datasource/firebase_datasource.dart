import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseDataSource {
  Stream<List<Map<String, dynamic>>> listenChatData({required String roomId});

  Future<void> sendMessage(
      {required String roomId, required Map<String, dynamic> data});
}

class FirebaseDataSourceImpl extends FirebaseDataSource {
  @override
  Stream<List<Map<String, dynamic>>> listenChatData({required String roomId}) {
    return FirebaseFirestore.instance
        .collection('chat')
        .doc(roomId)
        .collection('message')
        .orderBy('time')
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  @override
  Future<void> sendMessage(
      {required String roomId, required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection('chat')
        .doc(roomId)
        .collection('message')
        .add(data);
  }
}
