import 'package:get/get.dart';
import 'package:tripmates/controller/creatingProfileController.dart';

class creatingProfileScreenBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<CreatingProfileController>(()=>CreatingProfileController());
  }
}