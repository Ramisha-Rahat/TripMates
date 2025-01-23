import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/HomeScreenTravelAgent/homePageAgent.dart';
import 'package:tripmates/View/HomeScreenTraveller/homePage.dart';
import 'package:tripmates/bindings/creatingProfileScreenBinding.dart';
import '../../controller/creatingProfileController.dart';

class Intropage3 extends StatefulWidget {
  const Intropage3({super.key});

  @override
  State<Intropage3> createState() => _Intropage3State();
}

class _Intropage3State extends State<Intropage3> {

  final CreatingProfileController _controller = Get.find<CreatingProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Center(
          child: Container(
            height: 500,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Choose your role:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    final userId = FirebaseAuth.instance.currentUser?.uid;
                    final controller = Get.find<CreatingProfileController>();

                    controller.selectRole('Traveller'); // Save selected role

                    final userProfile = {
                      'name': controller.userName.value,
                      'address': controller.userAddress.value,
                      'phone': controller.userPhone.value,
                      'bio': controller.userBio.value,
                      'role': controller.selectedRole.value,
                    };

                    try {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .set(userProfile);

                      // Navigate to the respective home screen
                      Get.to(() => Homepage());
                    } catch (e) {
                      print('Error saving profile: $e');
                      Get.snackbar('Error', 'Failed to save profile. Try again.');
                    }
                  },
                  child: const Text('I am a Traveller'),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final userId = FirebaseAuth.instance.currentUser?.uid;
                    final controller = Get.find<CreatingProfileController>();

                    controller.selectRole('Travel Agent'); // Save selected role

                    final userProfile = {
                      'name': controller.userName.value,
                      'address': controller.userAddress.value,
                      'phone': controller.userPhone.value,
                      'bio': controller.userBio.value,
                      'role': controller.selectedRole.value,
                    };

                    try {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .set(userProfile);

                      // Navigate to the respective home screen
                      Get.to(() => Homepageagent());
                    } catch (e) {
                      print('Error saving profile: $e');
                      Get.snackbar('Error', 'Failed to save profile. Try again.');
                    }
                  },
                  child: const Text('I am a Travell Agent'),
                ),

                const SizedBox(height: 40),
                // Display the selected role message
                Text(
                  _controller.selectedRole.value.isEmpty
                      ? 'Please select your role.'
                      : 'You have chosen to be a ${_controller.selectedRole.value}.',
                  style: TextStyle(
                    fontSize: 18,
                    color: _controller.selectedRole.isEmpty ? Colors.red : Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

