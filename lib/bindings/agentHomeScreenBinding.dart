import 'package:get/get.dart';

import '../controller/agentHomePageController.dart';

class Agenthomescreenbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgentHomePageController>(() => AgentHomePageController());
  }
}