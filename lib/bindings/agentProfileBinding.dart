import "package:get/get.dart";
import "package:tripmates/controller/agentProfileController.dart";

class AgentProfileBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<AgentProfileController>(()=>AgentProfileController());
  }
}

