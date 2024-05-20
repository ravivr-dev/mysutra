import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseDataSource {
  Stream<List<Map<String, dynamic>>> listenChatData({required String roomId});

  Future<void> sendMessage(
      {required String roomId, required Map<String, dynamic> data});

  Stream<Map<String, dynamic>?> listenUserData({required String userId});

  Future<void> setUserData(
      {required String userId, required Map<String, dynamic> map});
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

  @override
  Stream<Map<String, dynamic>?> listenUserData({required String userId}) {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .snapshots()
        .map((event) => event.data());
  }

  @override
  Future<void> setUserData(
      {required String userId, required Map<String, dynamic> map}) async {
    return FirebaseFirestore.instance.collection('user').doc(userId).set(
          map,
          SetOptions(merge: true),
        );
  }
}
