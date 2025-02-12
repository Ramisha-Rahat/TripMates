import 'package:get/get.dart';
import 'package:tripmates/controller/MainWrapperController.dart';

class Mainwrapperbinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<MainWrapperController>(() => MainWrapperController());
  }
}