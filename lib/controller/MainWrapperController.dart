import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainWrapperController extends GetxController {
  late PageController pageController;
  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Ensure PageController is initialized after widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController = PageController(initialPage: 0);
      print("PageController initialized successfully");
    });
  }

  void gotoTab(int page) {
    currentPage.value = page;
    if (pageController.hasClients) {
      pageController.jumpToPage(page);
    } else {
      print("PageController is not initialized yet.");
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
