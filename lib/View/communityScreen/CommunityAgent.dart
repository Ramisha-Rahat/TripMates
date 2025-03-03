import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/communityScreen/ChatScreen.dart';

import '../../controller/agentCommunityController.dart';
import '../../controller/communityPageController.dart';

class Communityagent extends StatelessWidget {
   Communityagent({super.key});

//    final CommunityPageController controller = Get.put(CommunityPageController());
//
//    @override
//    Widget build(BuildContext context) {
//      return Scaffold(
//        appBar: AppBar(title: const Text('Community')),
//        body: Column(
//          children: [
//            // Search Field
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: TextField(
//                onChanged: (value) => controller.searchQuery.value = value,
//                decoration: InputDecoration(
//                  hintText: 'Search users...',
//                  prefixIcon: const Icon(Icons.search),
//                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                ),
//              ),
//            ),
//            // User List
//            Expanded(
//              child: Obx(() {
//                if (controller.isLoading.value) {
//                  return const Center(child: CircularProgressIndicator());
//                }
//
//                final users = controller.filteredUsers;
//                if (users.isEmpty) {
//                  return const Center(child: Text('No users found.'));
//                }
//
//                return ListView.builder(
//                  itemCount: users.length,
//                  itemBuilder: (context, index) {
//                    final user = users[index];
//                    final receiverId = user['uid'] ?? '';
//                    final receiverEmail = user['email'] ?? '';
//                    final receiverPhotoUrl = user['photoUrl'] ?? '';
//
//                    return ListTile(
//                      leading: CircleAvatar(
//                        backgroundImage: receiverPhotoUrl.isNotEmpty
//                            ? NetworkImage(receiverPhotoUrl)
//                            : const AssetImage("assets/images/default_avatar.png")
//                        as ImageProvider,
//                      ),
//                      title: Text(user['name'] ?? 'Unknown'),
//                      subtitle: Text(receiverEmail),
//                      trailing: ElevatedButton(
//                        onPressed: () {
//                          Get.to(() => ChatScreen(
//                            receiverId: receiverId,
//                            receiverEmail: receiverEmail,
//                          ));
//                        },
//                        child: const Text("Start Chat"),
//                      ),
//                    );
//                  },
//                );
//              }),
//            ),
//          ],
//        ),
//      );
//    }
// }
  //final controller = Get.put(AgentCommunityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community')),
      // body: Obx(() => ListView.builder(
      //   itemCount: controller.travelers.length,
      //   itemBuilder: (context, index) {
      //     final traveler = controller.travelers[index];
      //     return ListTile(
      //       leading: CircleAvatar(
      //         backgroundImage: NetworkImage(traveler['photoUrl']),
      //       ),
      //       title: Text(traveler['name']),
      //       subtitle: Text(traveler['email']),
      //       onTap: () => controller.startChat(traveler['id']),
      //     );
      //   },
      // )),
    );
  }
}
