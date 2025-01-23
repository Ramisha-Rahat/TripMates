import 'package:get/get.dart';
import 'package:tripmates/controller/loginpageController.dart';

class LoginPageBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => LoginPageController());
  }
}