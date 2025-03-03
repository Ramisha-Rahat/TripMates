import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tripmates/model/messages.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        print('User Data: ${doc.data()}'); // Debug Output
        return doc.data();
      }).toList();
    });
  }


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

  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String>ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore.collection("chat_room").doc(chatRoomID).collection(
        "messages").orderBy('timestamp', descending: false).snapshots();
  }

  Future<String?> generateChatRoomID(String user1, String user2) async {
    final usersRef = _firestore.collection('users');

    // Check if both users exist
    final user1Doc = await usersRef.doc(user1).get();
    final user2Doc = await usersRef.doc(user2).get();

    if (!user1Doc.exists || !user2Doc.exists) {
      print("One or both users do not exist in Firestore.");
      return null; // Stop the process if any user is missing
    }

    // Sort user IDs to maintain consistency
    List<String> ids = [user1, user2];
    ids.sort();
    return ids.join('_');
  }

  Future<void> createChatRoom(String user1, String user2) async {
    String? chatRoomID = await generateChatRoomID(user1, user2);

    if (chatRoomID == null) {
      print("Cannot create chat room: One or both users are missing.");
      return;
    }

    await _firestore.collection("chat_room").doc(chatRoomID).set({
      'users': [user1, user2],
      'lastMessage': '',
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    print("Chat room created with ID: $chatRoomID");
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
    // ✅ Utility function to generate a consistent chat room ID


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