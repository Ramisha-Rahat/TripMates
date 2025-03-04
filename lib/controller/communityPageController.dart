import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../services/authservices.dart';

class CommunityPageController extends GetxController {
  final AuthServices _authServices = Get.find<AuthServices>();
  var currentUserRole = RxnString();

  @override
  void onInit() {
    super.onInit();
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
        currentUserRole.value = userDoc['role'];
      }
    }
  }
}
