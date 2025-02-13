import 'package:get/get.dart';
import 'package:tripmates/controller/MainWrapperController.dart';

class MainWrapperBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<MainWrapperController>(() => MainWrapperController());
  }
}