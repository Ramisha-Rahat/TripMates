import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../View/CreateProfile/creatingProfileScreen.dart';

class LoginPageController extends GetxController{

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs; // Observable for loading state

  void signin() async {
    isLoading.value = true; // Show loading spinner
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      isLoading.value = false;
      Get.to(() => CreatingProfileScreen());
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      showErrorMessage(e.message ?? 'An error occurred');
    }
  }

  void showErrorMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
