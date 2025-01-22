
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MainWrapperController extends GetxController {

 late PageController pageController;

RxInt currentPage=0.obs;


void gotoTab(int page){
  currentPage.value=page;
  pageController.jumpToPage(page);
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