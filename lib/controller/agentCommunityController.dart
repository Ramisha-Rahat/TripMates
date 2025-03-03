// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
//
// import '../View/communityScreen/ChatScreen.dart';
//
// class AgentCommunityController extends GetxController {
//   var travelers = <Map<String, dynamic>>[].obs;
//   final currentUserId = 'CURRENT_AGENT_ID';
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchTravelers();
//   }
//
//   void fetchTravelers() async {
//     final query = await FirebaseFirestore.instance
//         .collection('users')
//         .where('role', isEqualTo: 'traveller')
//         .get();
//
//     travelers.assignAll(query.docs
//         .where((doc) => doc.id != currentUserId)
//         .map((doc) => {'id': doc.id, ...doc.data()})
//         .toList());
//   }
//
//   void startChat(String travelerId) {
//     final chatRoomId = currentUserId.hashCode <= travelerId.hashCode
//         ? '$currentUserId\_$travelerId'
//         : '$travelerId\_$currentUserId';
//
//     Get.to(() => ChatScreen(chatRoomId: chatRoomId));
//   }
// }
