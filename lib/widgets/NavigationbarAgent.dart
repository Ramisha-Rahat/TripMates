// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tripmates/View/Profilescreen/agentProfileScreen.dart';
// import 'package:tripmates/View/ServicesofAgent/Bookings.dart';
// import 'package:tripmates/View/HomeScreenTravelAgent/homePageAgent.dart';
// import 'package:tripmates/View/communityScreen/CommunityAgent.dart';
// import 'package:zoom_tap_animation/zoom_tap_animation.dart';
// import '../controller/MainWrapperController.dart';
//
// class NavigationPageAgent extends StatelessWidget {
//   NavigationPageAgent({super.key});
//
//   MainWrapperController controller = Get.find<MainWrapperController>();
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: controller.pageController,
//         physics: const BouncingScrollPhysics(),
//         children: [
//           Homepageagent(),
//           Bookings(),
//           Communityagent(),
//           Agentprofilescreen()
//         ],
//       ),
//
//     bottomNavigationBar: BottomAppBar(
//         notchMargin: 10,
//         child: Container(
//           child:Obx(
//                 ()=> Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
// // Optional for spacing
//               children: [
//
//                 _bottomAppBarItem(
//                   context,
//                   icon: Icons.home, // Pass IconData here
//                   label: 'Home',
//                   page: 0,
//                 ),
//                 _bottomAppBarItem(
//                   context,
//                   icon: Icons.bookmark_border_sharp, // Pass IconData here
//                   label: 'Bookings',
//                   page: 1,
//                 ),
//                 _bottomAppBarItem(
//                   context,
//                   icon: Icons.people_alt, // Pass IconData here
//                   label: 'Communities',
//                   page: 2,
//                 ),
//                 _bottomAppBarItem(
//                   context,
//                   icon: Icons.person, // Pass IconData here
//                   label: 'Profile',
//                   page: 3,
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Widget _bottomAppBarItem(BuildContext context, {
//     required icon, // Change the type to IconData
//     required  page,
//     required  label, // Change the type to String
//   }) {
//     return ZoomTapAnimation(
//       onTap: ()=> controller.gotoTab(page),
//       child: Container(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon,
//               color: controller.currentPage == page ? Colors.blue : Colors.red,
//             ), // Create the Icon widget here
//             Text(label), // Display the text label here
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/AlertScreen/alertScreen.dart';
import 'package:tripmates/View/HomeScreenTravelAgent/homePageAgent.dart';
import 'package:tripmates/View/Profilescreen/agentProfileScreen.dart';
import 'package:tripmates/View/ServicesofAgent/Bookings.dart';
import 'package:tripmates/View/communityScreen/CommunityAgent.dart';
import 'package:tripmates/controller/MainWrapperController.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../View/AlertScreen/agentAlertScreen.dart';
import '../services/authservices.dart';

class Navigationbaragent extends StatelessWidget {
  Navigationbaragent({super.key});


  final MainWrapperController controller = Get.put(MainWrapperController());
  final AuthServices authServices = AuthServices(); // Instance of AuthServices


  @override
  Widget build(BuildContext context) {
    final user = authServices.getCurrentUser();
    final String userId = user?.uid ?? '';


    return Scaffold(
      body:PageView(
        controller: controller.pageController,
        physics:  const BouncingScrollPhysics(),
        children: [
          Homepageagent(),
          TravelAgentAlertScreen(agentId: userId),
          Bookings(),
          Communityagent(),
          Agentprofilescreen(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        child: Container(
          child:Obx(
                ()=> Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // Optional for spacing
              children: [

                _bottomAppBarItem(
                  context,
                  icon: Icons.home, // Pass IconData here
                  label: 'Home',
                  page: 0,
                ),
                _bottomAppBarItem(
                  context,
                  icon: Icons.ring_volume, // Pass IconData here
                  label: 'Alerts',
                  page: 1,
                ),
                _bottomAppBarItem(
                  context,
                  icon: Icons.bookmark_border_sharp, // Pass IconData here
                  label: 'Bookings',
                  page: 2,
                ),
                _bottomAppBarItem(
                  context,
                  icon: Icons.group_add, // Pass IconData here
                  label: 'Communities',
                  page: 3,
                ),
                _bottomAppBarItem(
                  context,
                  icon: Icons.person, // Pass IconData here
                  label: 'Profile',
                  page: 4,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _bottomAppBarItem(BuildContext context, {
    required icon, // Change the type to IconData
    required  page,
    required  label, // Change the type to String
  }) {
    return ZoomTapAnimation(
      onTap: ()=> controller.gotoTab(page),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
              color: controller.currentPage == page ? Colors.blue : Colors.red,
            ), // Create the Icon widget here
            Text(label), // Display the text label here
          ],
        ),
      ),
    );
  }
}