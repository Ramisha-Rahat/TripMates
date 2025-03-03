import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/AlertScreen/alertScreen.dart';
import 'package:tripmates/View/NearestLocationScreen/locationScreen.dart';
import 'package:tripmates/View/communityScreen/communityScreen.dart';
import 'package:tripmates/controller/MainWrapperController.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../View/HomeScreenTraveller/homePage.dart';
import '../View/Profilescreen/userProfilescreen.dart';
import '../services/authservices.dart';

class NavigationPage extends StatelessWidget {
  NavigationPage({super.key});

  final MainWrapperController controller = Get.put(MainWrapperController(), permanent: true);
  final AuthServices authServices = AuthServices(); // Instance of AuthServices

  @override
  Widget build(BuildContext context) {
    final user = authServices.getCurrentUser();
    final String userId = user?.uid ?? ''; // Get userId safely

    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const BouncingScrollPhysics(),
        children: [
          Homepage(),
          AlertScreen(userId: userId), // Pass the correct userId
          NearestLocationScreen(),
          CommunityScreen(),
          UserProfileScreen(),
        ].where((child) => child != null).toList(), // Ensure no null children
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        child: Obx(
              () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _bottomAppBarItem(
                icon: Icons.home,
                label: 'Home',
                page: 0,
              ),
              _bottomAppBarItem(
                icon: Icons.notifications,
                label: 'Alerts',
                page: 1,
              ),
              _bottomAppBarItem(
                icon: Icons.explore,
                label: 'Explore',
                page: 2,
              ),
              _bottomAppBarItem(
                icon: Icons.group,
                label: 'Community',
                page: 3,
              ),
              _bottomAppBarItem(
                icon: Icons.person,
                label: 'Profile',
                page: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBarItem({
    required IconData icon,
    required int page,
    required String label,
  }) {
    return ZoomTapAnimation(
      onTap: () => controller.gotoTab(page),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => Icon(
            icon,
            color: controller.currentPage == page
                ? Colors.blueAccent // Highlight color
                : Colors.grey, // Inactive color
          )),
          Text(
            label,
            style: TextStyle(
              color: controller.currentPage == page
                  ? Colors.blueAccent
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}