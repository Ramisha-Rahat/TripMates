import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tripmates/model/messages.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        print('User Data: ${doc.data()}'); // Debug Output
        return doc.data();
      }).toList();
    });

  }

  // Future<void> sendMessage(String receiverID, String message) async {
  //   final String currentUserID = _auth.currentUser!.uid;
  //   final String currentUserEmail = _auth.currentUser!.email!;
  //   final Timestamp timeStamp = Timestamp.now(); // Correct timestamp
  //
  //   // Create a new message
  //   Message newMessage = Message(
  //     senderID: currentUserID,
  //     senderEmail: currentUserEmail,
  //     receiverID: receiverID,
  //     messages: message,
  //     timestamp: timeStamp, // Use Timestamp without casting
  //   );
  //
  //   // Construct chatRoomID
  //   List<String> ids = [currentUserID, receiverID];
  //   ids.sort();
  //   String chatRoomID = ids.join('_');
  //
  //   // Add the message to Firestore
  //   await _firestore
  //       .collection("chat_room")
  //       .doc(chatRoomID)
  //       .collection("messages")
  //       .add(newMessage.toMap());
  // }

  Future<void> deleteMessage(String receiverID, String messageId) async {
    final String currentUserID = _auth.currentUser!.uid;
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    await _firestore
        .collection("chat_room")
        .doc(chatRoomID)
        .collection("messages")
        .doc(messageId)
        .delete();
  }

  Stream<QuerySnapshot> getMessages(String userID, otherUserID){
    List<String>ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID=ids.join('_');

    return _firestore.collection("chat_room").doc(chatRoomID).collection("messages").orderBy('timestamp', descending: false).snapshots();
  }

  Future<void> sendMessage(String receiverID, String message) async {
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timeStamp = Timestamp.now();

    // Create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      messages: message,
      timestamp: timeStamp,
    );

    // Generate consistent chatRoomID
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // Ensure the order is always the same
    String chatRoomID = ids.join('_');

    // Add the message to Firestore
    await _firestore
        .collection("chat_room")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());

    // ✅ Update or Create a chat room record for sorting
    await _firestore.collection("chat_room").doc(chatRoomID).set({
      'lastMessage': message,
      'timestamp': timeStamp,
      'users': [currentUserID, receiverID],
    }, SetOptions(merge: true));
  }



}
