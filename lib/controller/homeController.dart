import 'package:get/get.dart';
import '../View/AlertScreen/alertScreen.dart';
import '../View/HomeScreenTraveller/homePage.dart';
import '../View/NearestLocationScreen/locationScreen.dart';
import '../View/Profilescreen/userProfilescreen.dart';
import '../services/authservices.dart';

class HomeController extends GetxController {
  var tabindex = 0.obs;

  final AuthServices _authServices = AuthServices(); // Create instance

  var homePage = Homepage();
  var nearestLocationPage = NearestLocationScreen();
  late var alertPage; // Delay initialization
  var profilePage = UserProfileScreen();

  @override
  void onInit() {
    super.onInit();

    final user = _authServices.getCurrentUser();
    if (user != null) {
      alertPage = AlertScreen(userId: user.uid);
    } else {
      alertPage = AlertScreen(userId: 'guest');
    }
  }

  // Method to change tab index
  void changeTabIndex(int index) {
    tabindex.value = index;
  }
}
