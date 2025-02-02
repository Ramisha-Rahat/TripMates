// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
//
// class UserProfileController extends GetxController {
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   final Rx<User?> user = FirebaseAuth.instance.currentUser.obs;
//
//   RxString photoUrl = ''.obs;
//   RxString displayName = ''.obs;
//   RxString email = ''.obs;
//   RxString selectedRole = ''.obs;
//   RxString userName = ''.obs;
//   RxString userAddress = ''.obs;
//   RxString userPhone = ''.obs;
//   RxString userBio = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _loadUserData();
//   }
//
//   /// **Load User Data from Firestore**
//   void _loadUserData() async {
//     if (user.value != null) {
//       email.value = user.value?.email ?? '';
//
//       DocumentSnapshot userDoc =
//       await _firestore.collection('users').doc(user.value!.uid).get();
//
//       if (userDoc.exists) {
//         displayName.value = userDoc['displayName'] ?? '';
//         userPhone.value = userDoc['phoneNumber'] ?? '';
//         userAddress.value = userDoc['address'] ?? '';
//         userBio.value = userDoc['bio'] ?? '';
//         selectedRole.value = userDoc['role'] ?? 'User';
//       }
//     }
//   }
//
//   /// **Update User Profile in Firestore**
//   Future<void> updateUserProfile() async {
//     if (user.value == null) return;
//
//     try {
//       await _firestore.collection('users').doc(user.value!.uid).update({
//         'displayName': displayName.value,
//         'phoneNumber': userPhone.value,
//         'address': userAddress.value,
//         'bio': userBio.value,
//       });
//
//       Get.snackbar("Success", "Profile updated successfully!",
//           snackPosition: SnackPosition.BOTTOM);
//     } catch (e) {
//       Get.snackbar("Error", "Failed to update profile!",
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//
//
//   void fetchUserData() async {
//     var userSnapshot = await FirebaseFirestore.instance.collection("users").doc(currentUserId).get();
//     if (userSnapshot.exists) {
//       displayName.value = userSnapshot.data()?["name"] ?? "";
//       email.value = userSnapshot.data()?["email"] ?? "";
//       userPhone.value = userSnapshot.data()?["phone"] ?? "";
//       userAddress.value = userSnapshot.data()?["city"] ?? "";
//       selectedRole.value = userSnapshot.data()?["role"] ?? "";
//       userBio.value = userSnapshot.data()?["bio"] ?? "";
//     }
//   }
//
//   void updateUserProfile() async {
//     await FirebaseFirestore.instance.collection("users").doc(currentUserId).update({
//       "name": displayName.value,
//       "phone": userPhone.value,
//       "city": userAddress.value,
//       "bio": userBio.value,
//     });
//   }
//
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Rx<User?> user = FirebaseAuth.instance.currentUser.obs;

  RxString displayName = ''.obs;
  RxString email = ''.obs;
  RxString userPhone = ''.obs;
  RxString userAddress = ''.obs;
  RxString userBio = ''.obs;
  RxString selectedRole = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
    if (user.value == null) return;

    var userDoc = await _firestore.collection("users").doc(user.value!.uid).get();
    if (userDoc.exists) {
      displayName.value = userDoc["displayName"] ?? "";
      email.value = userDoc["email"] ?? "";
      userPhone.value = userDoc["phoneNumber"] ?? "";
      userAddress.value = userDoc["address"] ?? "";
      userBio.value = userDoc["bio"] ?? "";
      selectedRole.value = userDoc["role"] ?? "User";
    }
  }

  Future<void> updateUserProfile() async {
    if (user.value == null) return;

    try {
      await _firestore.collection("users").doc(user.value!.uid).update({
        "displayName": displayName.value,
        "phoneNumber": userPhone.value,
        "address": userAddress.value,
        "bio": userBio.value,
      });

      Get.snackbar("Success", "Profile updated successfully!",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile!",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
