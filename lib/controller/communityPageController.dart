// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:get/get.dart';
// //
// // class CommunityPageController extends GetxController {
// //   final RxString searchQuery = ''.obs;
// //   final RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;
// //
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchUsers();
// //   }
// //
// //   void fetchUsers() {
// //     final currentUserId = _auth.currentUser?.uid;
// //
// //     _firestore.collection('users').snapshots().listen((snapshot) {
// //       users.value = snapshot.docs
// //           .map((doc) => doc.data())
// //           .where((user) => user['uid'] != currentUserId) // Exclude logged-in user
// //           .toList();
// //     });
// //   }
// //
// //   List<Map<String, dynamic>> get filteredUsers {
// //     if (searchQuery.value.isEmpty) return users;
// //     return users.where((user) {
// //       final userName = (user["name"] ?? "").toLowerCase();
// //       return userName.contains(searchQuery.value);
// //     }).toList();
// //   }
// //
// //   Stream<List<Map<String, dynamic>>> getChatRooms() {
// //     final currentUserID = _auth.currentUser!.uid;
// //
// //     return _firestore
// //         .collection("chat_room")
// //         .where("users", arrayContains: currentUserID) // Only chats involving the current user
// //         .orderBy("timestamp", descending: true) // Sort by latest message
// //         .snapshots()
// //         .map((snapshot) =>
// //         snapshot.docs.map((doc) => doc.data()).toList());
// //   }
// //
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
//
// class CommunityPageController extends GetxController {
//   final RxString searchQuery = ''.obs;
//   final RxList<Map<String, dynamic>> chatUsers = <Map<String, dynamic>>[].obs;
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchChatUsers();
//   }
//
//   void fetchChatUsers() {
//     final currentUserId = _auth.currentUser?.uid;
//     if (currentUserId == null) return;
//
//     _firestore
//         .collection('chat_room')
//         .where('users', arrayContains: currentUserId) // Fetch chat rooms with current user
//         .snapshots()
//         .listen((snapshot) async {
//       final uniqueUserIds = <String>{};
//
//       for (var doc in snapshot.docs) {
//         List<dynamic> users = doc["users"];
//         for (var userId in users) {
//           if (userId != currentUserId) uniqueUserIds.add(userId);
//         }
//       }
//
//       if (uniqueUserIds.isEmpty) {
//         chatUsers.clear();
//         return;
//       }
//
//       // Fetch user data for users in the chat room
//       final userDocs = await _firestore
//           .collection('users')
//           .where('uid', whereIn: uniqueUserIds.toList())
//           .get();
//
//       chatUsers.value = userDocs.docs.map((doc) => doc.data()).toList();
//     });
//   }
//
//
//   // ✅ Filter chat users based on search
//   List<Map<String, dynamic>> get filteredUsers {
//     if (searchQuery.value.isEmpty) return chatUsers;
//     return chatUsers.where((user) {
//       final userName = (user["name"] ?? "").toLowerCase();
//       return userName.contains(searchQuery.value.toLowerCase());
//     }).toList();
//   }
//
//   // ✅ Send message to the correct recipient
//   Future<void> sendMessage(String receiverId, String message) async {
//     final currentUserId = _auth.currentUser!.uid;
//
//     // Chat room ID by combining user IDs
//     final chatRoomId = currentUserId.compareTo(receiverId) < 0
//         ? '$currentUserId\_$receiverId'
//         : '$receiverId\_$currentUserId';
//
//     final chatRoomRef = _firestore.collection('chat_room').doc(chatRoomId);
//
//     // Ensure chat room exists
//     await chatRoomRef.set({
//       'users': [currentUserId, receiverId],
//       'lastMessage': message,
//       'timestamp': FieldValue.serverTimestamp(),
//     }, SetOptions(merge: true));
//
//     // Add message to chat
//     await chatRoomRef.collection('messages').add({
//       'senderId': currentUserId,
//       'receiverId': receiverId,
//       'message': message,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//   }
//
//   // ✅ Stream chat rooms for the current user (sorted by latest message)
//   Stream<List<Map<String, dynamic>>> getChatRooms() {
//     final currentUserId = _auth.currentUser!.uid;
//
//     return _firestore
//         .collection('chat_room')
//         .where('users', arrayContains: currentUserId)
//         .orderBy('timestamp', descending: true) // Sort by recent chats
//         .snapshots()
//         .map((snapshot) =>
//         snapshot.docs.map((doc) => doc.data()).toList());
//   }
// }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
//
// class CommunityPageController extends GetxController {
//   final RxString searchQuery = ''.obs;
//   final RxList<Map<String, dynamic>> chatUsers = <Map<String, dynamic>>[].obs;
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchChatUsers();
//   }
//
//   void fetchChatUsers() {
//     final currentUserId = _auth.currentUser?.uid;
//     if (currentUserId == null) return;
//
//     _firestore
//         .collection('chat_room')
//         .where('users', arrayContains: currentUserId)
//         .snapshots()
//         .listen((snapshot) async {
//       final Set<String> uniqueUserIds = {};
//
//       for (var doc in snapshot.docs) {
//         List<dynamic> users = doc["users"];
//         for (var userId in users) {
//           if (userId != currentUserId && userId.isNotEmpty) {
//             uniqueUserIds.add(userId);
//           }
//         }
//       }
//
//       if (uniqueUserIds.isEmpty) {
//         chatUsers.clear();
//         return;
//       }
//
//       // Fetch user info for active chat users
//       final userDocs = await _firestore
//           .collection('users')
//           .where('uid', whereIn: uniqueUserIds.toList())
//           .get();
//
//       chatUsers.value = userDocs.docs.map((doc) => doc.data()).toList();
//       chatUsers.refresh();
//     });
//   }
//
//   List<Map<String, dynamic>> get filteredUsers {
//     if (searchQuery.value.isEmpty) return chatUsers;
//     return chatUsers.where((user) {
//       final userName = (user["name"] ?? "").toLowerCase();
//       return userName.contains(searchQuery.value.toLowerCase());
//     }).toList();
//   }
//   Future<void> sendMessage(String receiverId, String message) async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null || receiverId.isEmpty) return;
//
//     final chatRoomId = currentUser.uid.compareTo(receiverId) < 0
//         ? '${currentUser.uid}_$receiverId'
//         : '${receiverId}_${currentUser.uid}';
//
//     final chatRoomRef = FirebaseFirestore.instance.collection('chat_room').doc(chatRoomId);
//
//     // Ensure chat room exists or update lastMessage
//     await chatRoomRef.set({
//       'users': [currentUser.uid, receiverId],
//       'lastMessage': message,
//       'timestamp': FieldValue.serverTimestamp(),
//     }, SetOptions(merge: true));
//
//     // Store the message with sender and receiver IDs
//     await chatRoomRef.collection('messages').add({
//       'senderID': currentUser.uid,
//       'receiverID': receiverId,
//       'message': message,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//   }
//
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CommunityPageController extends GetxController {
  final RxString searchQuery = ''.obs;
  final RxList<Map<String, dynamic>> chatUsers = <Map<String, dynamic>>[].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchChatUsers();
  }

  void fetchChatUsers() {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) return;

    _firestore
        .collection('chat_room')
        .where('users', arrayContains: currentUserId)
        .snapshots()
        .listen((snapshot) async {
      final Set<String> uniqueUserIds = {};

      for (var doc in snapshot.docs) {
        List<dynamic> users = doc["users"];
        for (var userId in users) {
          if (userId != currentUserId && userId.isNotEmpty) {
            uniqueUserIds.add(userId);
          }
        }
      }

      if (uniqueUserIds.isEmpty) {
        chatUsers.clear();
        return;
      }

      // Fetch user info for active chat users
      final userDocs = await _firestore
          .collection('users')
          .where('uid', whereIn: uniqueUserIds.toList())
          .get();

      chatUsers.value = userDocs.docs.map((doc) => doc.data()).toList();
      chatUsers.refresh();
    });
  }

  List<Map<String, dynamic>> get filteredUsers {
    if (searchQuery.value.isEmpty) return chatUsers;
    return chatUsers.where((user) {
      final userName = (user["name"] ?? "").toLowerCase();
      return userName.contains(searchQuery.value.toLowerCase());
    }).toList();
  }
}
