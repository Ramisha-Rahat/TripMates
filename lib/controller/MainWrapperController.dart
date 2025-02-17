import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MainWrapperController extends GetxController {

 late PageController pageController;

 RxInt currentPage=0.obs;

 // void gotoTab(int page) {
 //   currentPage.value = page;
 //   if (pageController.hasClients) {
 //     pageController.jumpToPage(page);
 //   }
 // }
 void gotoTab(int page) {
   currentPage.value = page;
   if (pageController.hasClients) {
     pageController.jumpToPage(page);
   } else {
     print("PageController is not initialized yet.");
   }
 }


@override
void onInit(){
  pageController=PageController(initialPage:0);
  super.onInit();
}

@override
  void onClose(){
pageController.dispose();
super.onClose();
}

}