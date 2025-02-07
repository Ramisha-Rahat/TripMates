import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Rx<User?> user = FirebaseAuth.instance.currentUser.obs;


  final RxString photoUrl = ''.obs;
  RxString displayName = ''.obs;
  RxString email = ''.obs;
  RxString selectedRole = ''.obs;
  RxString userName = ''.obs;
  RxString userAddress = ''.obs;
  RxString userPhone = ''.obs;
  RxString userBio = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  /// **Load User Data from Firestore**
  void fetchUserData() async {
    if (user.value == null) return;

    var userSnapshot = await _firestore.collection("users")
        .doc(user.value?.uid)
        .get();
    if (userSnapshot.exists) {
      displayName.value = userSnapshot.data()?["name"] ?? "";
      email.value = user.value?.email ?? "";
      userPhone.value = userSnapshot.data()?["phone"] ?? "";
      userAddress.value = userSnapshot.data()?["address"] ?? "";
      selectedRole.value = userSnapshot.data()?["role"] ?? "";
      userBio.value = userSnapshot.data()?["bio"] ?? "";
    }
  }

  /// **Update User Profile in Firestore**
  Future<void> updateUserProfile() async {
    if (user.value == null) return;

    try {
      await _firestore.collection("users").doc(user.value?.uid).update({
        "name": displayName.value,
        "phone": userPhone.value,
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

  // Future<void> pickAndUploadImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     File imageFile = File(pickedFile.path);
  //    String imageUrl = await uploadImageToCloudinary(imageFile);
  //
  //     if (imageUrl.isNotEmpty) {
  //       photoUrl.value = imageUrl;
  //       print('Uploaded image URL: $imageUrl');
  //     }
  //   }
  // }

  // Future<String> uploadImageToCloudinary(File imageFile) async {
  //   String cloudName = "dlc8c60ap";
  //   String uploadPreset = "example";
  //
  //   var url = Uri.parse('https://api.cloudinary.com/v1_1/dlc8c60ap/image/upload');
  //   //
  //   // var request = http.MultipartRequest('POST', url)
  //   //   ..fields['upload_preset'] = uploadPreset
  //   //   ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));
  //   //
  //   // var response = await request.send();
  //   //
  //   // if (response.statusCode == 200) {
  //   //   var jsonResponse = json.decode(await response.stream.bytesToString());
  //   //   return jsonResponse['secure_url']; // Cloudinary returns the uploaded image URL
  //   // } else {
  //   //   print('Failed to upload image');
  //   //   return '';
  //   // }
  // }
}

