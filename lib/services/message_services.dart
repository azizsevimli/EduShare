import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String generateChatId({required String userId1, required String userId2}) {
    return userId1.compareTo(userId2) < 0
        ? '${userId1}_$userId2'
        : '${userId2}_$userId1';
  }

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String materialId,
    required String text,
  }) async {
    final chatId = generateChatId(userId1: senderId, userId2: receiverId);
    final message = MessageModel(
      senderId: senderId,
      materialId: materialId,
      text: text,
      timestamp: DateTime.now(),
    );

    final messageRef = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc();

    await messageRef.set(message.toMap());

    await _firestore.collection('chats').doc(chatId).set({
      'users': [senderId, receiverId],
      'lastMessage': text,
      'timestamp': DateTime.now().toIso8601String(),
    }, SetOptions(merge: true));
  }

  Stream<List<MessageModel>> getMessages({
    required String userId1,
    required String userId2,
  }) {
    final chatId = generateChatId(userId1: userId1, userId2: userId2);
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.data()))
            .toList());
  }

  Future<List<Map<String, dynamic>>> getChatsForUser({
    required String currentUserId,
  }) async {
    final querySnapshot = await _firestore
        .collection('chats')
        .where('users', arrayContains: currentUserId)
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      final users = List<String>.from(data['users']);
      final targetUserId = users.firstWhere((id) => id != currentUserId);

      return {
        'chatId': doc.id,
        'targetUserId': targetUserId,
        'lastMessage': data['lastMessage'] ?? '',
        'timestamp': data['timestamp'],
      };
    }).toList();
  }
}
