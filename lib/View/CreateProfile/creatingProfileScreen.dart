import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../controller/creatingProfileController.dart';
import '../HomeScreenTraveller/homePage.dart';
import 'IntroPage1.dart';
import 'IntroPage2.dart';
import 'IntroPage3.dart';

class CreatingProfileScreen extends StatelessWidget {
  CreatingProfileScreen({super.key});

  final CreatingProfileController _controller =
  Get.put(CreatingProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller.pageController, // Link PageController to PageView
            onPageChanged: (index) {
              _controller.updatePageStatus(index);
            },
            children: [
              Intropage1(),
               Intropage2(),
               Intropage3(),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.pageController.jumpToPage(2); // Jump to the last page
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller.pageController, // Bind the controller
                  count: 3,
                  effect: const WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: Colors.blue,
                  ),
                ),
                Obx(() {
                  return _controller.isLastPage.value
                      ? GestureDetector(
                    onTap: () {
                      Get.to(() => Homepage());
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      _controller.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
