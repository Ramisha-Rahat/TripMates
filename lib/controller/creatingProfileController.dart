import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreatingProfileController extends GetxController{

  final PageController pageController = PageController();
  RxBool isLastPage = false.obs;

  void updatePageStatus(int index) {
    isLastPage.value = (index == 2);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

}