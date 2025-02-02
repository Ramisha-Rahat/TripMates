// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../View/CreateProfile/creatingProfileScreen.dart';
//
// class SignUpController extends GetxController {
//
//   var usernameController = TextEditingController();
//   var passwordController = TextEditingController();
//   var rePasswordController = TextEditingController();
//   var isLoading = false.obs;
//
//   void register(BuildContext context) async {
//     if (isLoading.value) return; // Prevent multiple clicks
//     isLoading.value = true;
//
//     if (passwordController.text == rePasswordController.text) {
//       try {
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: usernameController.text,
//           password: passwordController.text,
//         );
//         isLoading.value = false;
//         Get.to(() => CreatingProfileScreen());
//       } on FirebaseAuthException catch (e) {
//         isLoading.value = false;
//         showErrorMessage(context, e.message ?? 'An error occurred');
//       }
//     } else {
//       isLoading.value = false;
//       showErrorMessage(context, "Passwords do not match");
//     }
//   }
//
//   void showErrorMessage(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.lightBlueAccent,
//           title: Text('Error'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripmates/View/CreateProfile/creatingProfileScreen.dart';


class SignUpController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var isLoading = false.obs;

  void register() async {
    if (isLoading.value) return; // Prevent multiple clicks
    isLoading.value = true;


    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String rePassword = rePasswordController.text.trim();

    // Email & Password Validation
    if (!GetUtils.isEmail(email)) {
      isLoading.value = false;
      showError("Invalid email format");
      return;
    }
    if (password.length < 6) {
      isLoading.value = false;
      showError("Password must be at least 6 characters long");
      return;
    }
    if (password != rePassword) {
      isLoading.value = false;
      showError("Passwords do not match");
      return;
    }

    // Firebase Registration
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoading.value = false;
      Get.off(() => CreatingProfileScreen()); // Use Get.off to prevent going back
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      showError(e.message ?? "An error occurred");
    }
  }

  void showError(String message) {
    Get.snackbar(
      "Error",
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
