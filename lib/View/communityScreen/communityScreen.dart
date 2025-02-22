import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/communityScreen/ChatScreen.dart';
import 'package:tripmates/controller/communityPageController.dart';
import 'package:tripmates/widgets/userTile.dart';

class Communityscreen extends StatelessWidget {
  Communityscreen({super.key});

  final CommunityPageController _controller = Get.put(CommunityPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: Column(
        children: [
          // Search Input Field
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                _controller.searchQuery.value = value.toLowerCase();
             //   print("Search Query: ${_controller.searchQuery.value}");
              },
              decoration: InputDecoration(
                hintText: "Search users...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),

          // User List (Reactive with Obx)
          Expanded(
            child: Obx(() {
              final users = _controller.filteredUsers;

              if (users.isEmpty) {
                return const Center(child: Text("No matching users found."));
              }

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return _buildUserListItem(users[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // Build Individual User Tile
  Widget _buildUserListItem(Map<String, dynamic> userData) {
    final String userName = userData["name"] ?? "Unknown User";
    final String userRole = userData["role"] ?? "No Role";
    final String photoUrl = userData["photoUrl"] ?? "";

    return UserTile(
      title: userName,
      subtitle: userRole,
      imageUrl: photoUrl,
      onTap: () {
        // Navigate to the chat screen
        Get.to(() => ChatScreen(recieverEmail: userName));
      },
    );
  }
}
