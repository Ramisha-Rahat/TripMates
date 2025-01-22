import 'package:get/get.dart';
import 'package:tripmates/controller/userProfileController.dart';

class userprofile extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UserProfileController>(()=>UserProfileController());
  }

}