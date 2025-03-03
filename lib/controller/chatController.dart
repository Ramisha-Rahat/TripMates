import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var messages = <Map<String, dynamic>>[].obs;
  final currentUserId = 'CURRENT_USER_ID';
  final messageController = TextEditingController();

  void initChat(String chatRoomId) async {
    FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .listen((snapshot) {
      messages.assignAll(snapshot.docs.map((doc) => doc.data()).toList());
    });
  }

  void sendMessage(String chatRoomId) async {
    if (messageController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add({
        'senderId': currentUserId,
        'message': messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      messageController.clear();
    }
  }
}
