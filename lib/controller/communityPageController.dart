import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CommunityPageController extends GetxController {



}

//   // Reactive variables
//   var users = <Map<String, dynamic>>[].obs; // Stores the user list
//   final RxBool isLoading = false.obs; // Loading indicator
//
//   // Firebase instances
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // Get current user
//   User? get currentUser => _auth.currentUser;
//
//   // Get user role
//   Future<String?> getCurrentUserRole() async {
//     final doc = await _firestore.collection('users').doc(currentUser?.uid).get();
//     return doc.data()?['role'];
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchUsers();
//   }
//
//   // ✅ Fetch users based on the current user's role
//   Future<void> fetchUsers() async {
//     if (currentUser == null) return;
//
//     try {
//       isLoading(true);
//       final currentUserRole = await getCurrentUserRole();
//
//       // Determine target role (travelers see agents and vice versa)
//       String targetRole = currentUserRole == 'Traveler' ? 'Travel Agent' : 'Traveler';
//
//       final query = await _firestore
//           .collection('users')
//           .where('role', isEqualTo: targetRole)
//           .get();
//
//       // Filter out current user
//       users.assignAll(query.docs
//           .where((doc) => doc.id != currentUser!.uid)
//           .map((doc) => {'id': doc.id, ...doc.data()})
//           .toList());
//     } catch (e) {
//       print("❌ Error fetching users: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   // ✅ Navigate to Chat Screen
//   void startChat(String receiverId) {
//     final currentUserId = currentUser?.uid ?? '';
//
//     // Create unique chatRoomId
//     final chatRoomId = currentUserId.hashCode <= receiverId.hashCode
//         ? '${currentUserId}_$receiverId'
//         : '${receiverId}_$currentUserId';
//
//     Get.to(() => ChatScreen(chatRoomId: chatRoomId));
//   }
// }
