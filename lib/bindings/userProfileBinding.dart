import 'package:get/get.dart';
import 'package:tripmates/controller/userProfileController.dart';

class UserProfileBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UserProfileController>(()=>UserProfileController());
  }

}