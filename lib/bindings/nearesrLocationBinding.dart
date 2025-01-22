import 'package:get/get.dart';
import 'package:tripmates/controller/nearestLocationController.dart';

class nearestlocationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NearestLocationcontroller>(()=>NearestLocationcontroller());
  }

}