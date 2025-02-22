import 'package:get/get.dart';
import 'package:tripmates/controller/communityPageController.dart';

class CommunityPageBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<CommunityPageController>(()=>CommunityPageController());
  }
}