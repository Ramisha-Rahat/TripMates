import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          SizedBox(height: 200,),
          Center(
            child: Text(
              'TripMates',
              style: TextStyle(fontSize: 30,color: Theme.of(context).colorScheme.primary,),
            ),
          ),
        ],
      ),
    );
  }
}
//metgod"
// void checkUserStatus() async {
//   User? user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     var userDoc = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
//
//     if (userDoc.exists && userDoc.data()?["role"] != null && userDoc.data()?["role"].toString().isNotEmpty) {
//       Get.offAll(() => TravelHomePage()); // User has completed profile setup
//     } else {
//       Get.offAll(() => CreatingProfileScreen()); // User needs to set up profile
//     }
//   } else {
//     Get.offAll(() => LoginPage()); // No user logged in
//   }
// }