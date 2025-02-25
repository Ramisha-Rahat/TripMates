import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/communityPageController.dart';
import '../communityScreen/ChatScreen.dart';

class CommunityScreen extends StatelessWidget {
  final CommunityPageController controller = Get.put(CommunityPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final users = controller.filteredUsers;
              if (users.isEmpty) {
                return Center(child: Text('No matching user found :('));
              }
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final String receiverId = user['uid'] ?? '';
                  final String receiverEmail = user['email'] ?? '';
                  final String receiverPhotoUrl = user['photoUrl'] ?? '';

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(receiverPhotoUrl),
                    ),
                    title: Text(user['name'] ?? 'Unknown'),
                    subtitle: Text(receiverEmail),
                    onTap: () {
                      Get.to(() => ChatScreen(
                        receiverId: receiverId,
                        receiverEmail: receiverEmail,
                      ));
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
