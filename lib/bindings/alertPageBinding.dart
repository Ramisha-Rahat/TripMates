import 'package:get/get.dart';
import 'package:tripmates/controller/alertPageController.dart';

class Alertpagebinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AlertPageController>(()=>AlertPageController());
  }

}