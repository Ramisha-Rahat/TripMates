import 'package:get/get.dart';
import 'package:tripmates/controller/signupController.dart';

class SignUpBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}