import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/NavigationBar.dart';

class SignUpController extends GetxController {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var isLoading = false.obs;

  void register(BuildContext context) async {
    if (isLoading.value) return; // Prevent multiple clicks
    isLoading.value = true;

    if (passwordController.text == rePasswordController.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
        isLoading.value = false;
        Get.offAll(() => NavigationPage()); // Navigate to homepage
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        showErrorMessage(context, e.message ?? 'An error occurred');
      }
    } else {
      isLoading.value = false;
      showErrorMessage(context, "Passwords do not match");
    }
  }

  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.lightBlueAccent,
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
