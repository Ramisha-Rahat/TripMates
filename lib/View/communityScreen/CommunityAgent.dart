import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/communityScreen/ChatScreen.dart';
import '../../controller/communityPageController.dart';
import '../../services/authservices.dart';
import '../../services/chatService.dart';

class Communityagent extends StatelessWidget {
   Communityagent({super.key});

   final CommunityPageController _controller = Get.put(CommunityPageController());
   final AuthServices _authServices = Get.put(AuthServices());
   final ChatService _chatService = Get.put(ChatService());

   @override
   Widget build(BuildContext context) {
     final currentUser = _authServices.getCurrentUser();
     final currentUserId = currentUser?.uid;

     return Scaffold(
       appBar: AppBar(title: const Text('Traveller Community Screen'),
           centerTitle:true),
       body: Obx(() {
         if (_controller.currentUserRole.value == null) {
           return const Center(child: CircularProgressIndicator());
         }

         return StreamBuilder<QuerySnapshot>(
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
                   ((_controller.currentUserRole.value == 'Travel Agent' && userRole == 'Traveller') ||
                       (_controller.currentUserRole.value == 'Traveller' && userRole == 'Travel Agent'));
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
                         ? NetworkImage(receiverPhotoUrl) as ImageProvider
                         : const AssetImage("assets/images/AppLogo-TripMates.png"),
                     child: receiverPhotoUrl.isEmpty
                         ? const Icon(Icons.person)
                         : null,
                   ),
                   title: Text(receiverName),
                   onTap: () async {
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
         );
       }),
     );
   }
}
