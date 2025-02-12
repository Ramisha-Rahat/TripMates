import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/widgets/NavigationBar.dart';
import 'package:tripmates/widgets/NavigationbarAgent.dart';

import '../View/CreateProfile/creatingProfileScreen.dart';

class LoginPageController extends GetxController{

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs; // Observable for loading state

  void signin() async {
    isLoading.value = true; // Show loading spinner
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {

        var userDoc = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();

        if (userDoc.exists && userDoc.data()?["role"] != null && userDoc.data()!["role"].toString().isNotEmpty) {
          if( userDoc.data()?["role"] =="Traveller" ) {
            Get.offAll(() => NavigationPage());
          }
          else if(userDoc.data()?["role"]=='Travel Agent'){
               Get.offAll(()=>NavigationPageAgent());
          }
        } else {
          Get.offAll(() => CreatingProfileScreen());
        }
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message ?? 'An error occurred');
    } finally {
      isLoading.value = false;
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