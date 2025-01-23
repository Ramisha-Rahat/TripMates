import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreatingProfileController extends GetxController{

  final PageController pageController = PageController();
  RxBool isLastPage = false.obs;
  RxString selectedRole = ''.obs;

  var userName = ''.obs;
  var userAddress = ''.obs;
  var userPhone = ''.obs;
  var userBio = ''.obs;
 // var selectedRole = ''.obs;

  final Rx<User?> user = FirebaseAuth.instance.currentUser.obs;
  RxString photoUrl = ''.obs;
  RxString displayName = ''.obs;
  RxString email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Update observables with user details
    if (user.value != null) {
      photoUrl.value = user.value?.photoURL ?? '';
      displayName.value = user.value?.displayName ?? 'User';
      email.value = user.value?.email ?? '';
    }
  }

  void updatePageStatus(int index) {
    isLastPage.value = (index == 3);
  }

  void selectRole(String role) {
    selectedRole.value = role; // Update the selected role
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

}