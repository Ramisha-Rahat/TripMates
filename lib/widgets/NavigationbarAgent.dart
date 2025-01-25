import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/HomeScreenTravelAgent/ServiceAgent.dart';
import 'package:tripmates/View/HomeScreenTravelAgent/homePageAgent.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../View/Profilescreen/agentProfileScreen.dart';
import '../controller/Main_Wrapper_Navigator.dart';


class NavigationPageAgent extends StatelessWidget {
  NavigationPageAgent({super.key});


  final MainWrapperController controller=Get.put(MainWrapperController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView(
        controller: controller.pageController,
        physics:  const BouncingScrollPhysics(),
        children: [
          Homepageagent(),
          Homepageagent(),
          ServiceagentScreen(),
          Homepageagent(),
          Agentprofilescreen(),
          Homepageagent(),

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
                  icon: Icons.book_sharp, // Pass IconData here
                  label: 'Booking',
                  page: 1,
                ),
                _bottomAppBarItem(
                  context,
                  icon: Icons.miscellaneous_services_sharp, // Pass IconData here
                  label: 'Services',
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