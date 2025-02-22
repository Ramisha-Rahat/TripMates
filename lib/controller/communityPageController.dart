import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CommunityPageController extends GetxController {
  final RxString searchQuery = ''.obs; // Observable for search query
  final RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs; // Observable user list

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  // Fetch Users from Firestore
  void fetchUsers() {
    _firestore.collection('users').snapshots().listen((snapshot) {
      users.value = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  // Filtered Users
  List<Map<String, dynamic>> get filteredUsers {
    if (searchQuery.value.isEmpty) {
      return users;
    }
    return users.where((user) {
      final userName = (user["name"] ?? "").toLowerCase();
      return userName.contains(searchQuery.value);
    }).toList();
  }
}
