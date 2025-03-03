// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:tripmates/controller/communityPageController.dart';
// import '../../services/authservices.dart';
// import '../../services/chatService.dart';
// import '../communityScreen/ChatScreen.dart';
//
// class CommunityScreen extends StatefulWidget {
//
//   CommunityScreen({Key? key}) : super(key: key);
//
//   @override
//   State<CommunityScreen> createState() => _CommunityScreenState();
// }
//
// class _CommunityScreenState extends State<CommunityScreen> {
//
//   final CommunityPageController _controller=Get.put(CommunityPageController());
//   final AuthServices _authServices = Get.find<AuthServices>();
//   final ChatService _chatService = Get.find<ChatService>();
//
//   @override
//   Widget build(BuildContext context) {
//     final currentUser = _authServices.getCurrentUser();
//     final currentUserId = currentUser?.uid;
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Community')),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('users').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No users found.'));
//           }
//
//           final users = snapshot.data!.docs.where((user) {
//             return user.id != currentUserId;
//           }).toList();
//
//           return ListView.builder(
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];
//               final receiverId = user.id;
//               final receiverName = user['name'];
//               final receiverPhotoUrl = user['photoUrl'] ?? "";
//
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: receiverPhotoUrl.isNotEmpty
//                       ? NetworkImage(receiverPhotoUrl)
//                       : null,
//                   child: receiverPhotoUrl.isEmpty
//                       ? const Icon(Icons.person)
//                       : null,
//                 ),
//                 title: Text(receiverName),
//                 onTap: () async {
//                    Get.to(() => ChatScreen(chatRoomId:));
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tripmates/controller/communityPageController.dart';
import '../../services/authservices.dart';
import '../../services/chatService.dart';
import '../communityScreen/ChatScreen.dart';

class CommunityScreen extends StatefulWidget {
  CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final CommunityPageController _controller = Get.put(CommunityPageController());
  final AuthServices _authServices = Get.find<AuthServices>();
  final ChatService _chatService = Get.find<ChatService>();
  String? currentUserRole;

  @override
  void initState() {
    super.initState();
    fetchCurrentUserRole();
  }

  Future<void> fetchCurrentUserRole() async {
    final currentUser = _authServices.getCurrentUser();
    if (currentUser != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          currentUserRole = userDoc['role'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = _authServices.getCurrentUser();
    final currentUserId = currentUser?.uid;

    if (currentUserRole == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Community')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users found.'));
          }

          // Filter users based on role
          final users = snapshot.data!.docs.where((user) {
            final userRole = user['role'];
            return user.id != currentUserId &&
                ((currentUserRole == 'traveller' && userRole == 'travel_agent') ||
                    (currentUserRole == 'travel_agent' && userRole == 'traveller'));
          }).toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final receiverId = user.id;
              final receiverName = user['name'];
              final receiverPhotoUrl = user['photoUrl'] ?? "";

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: receiverPhotoUrl.isNotEmpty
                      ? NetworkImage(receiverPhotoUrl)
                      : null,
                  child: receiverPhotoUrl.isEmpty
                      ? const Icon(Icons.person)
                      : null,
                ),
                title: Text(receiverName),
                onTap: () async {
                  // Generate chat room ID and navigate to ChatScreen
                  final chatRoomId = await _chatService.generateChatRoomID(currentUserId!, receiverId);
                  if (chatRoomId != null) {
                    Get.to(() => ChatScreen(
                      chatRoomId: chatRoomId,
                      receiverId: receiverId,
                      receiverName: receiverName,
                    ));
                  } else {
                    Get.snackbar('Error', 'Unable to create chat room.');
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}