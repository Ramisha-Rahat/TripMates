import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsernameController extends GetxController {
  TextEditingController usernameController = TextEditingController();

  // Optional: Add a method to clear the text field
  void clearUsername() {
    usernameController.clear();
  }

  @override
  void onClose() {
    usernameController.dispose();
    super.onClose();
  }
}
