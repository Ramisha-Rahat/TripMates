import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SquareButtonController extends GetxController {
  // Example of GetX controller for managing state
  var isLoggedIn = false.obs; // Reactive state to track login status

  void toggleLoginStatus() {
    isLoggedIn.value = !isLoggedIn.value; // Toggle the login status
  }
}