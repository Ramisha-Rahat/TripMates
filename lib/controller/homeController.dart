import 'package:get/get.dart';
import '../View/AlertScreen/alertScreen.dart';
import '../View/HomeScreenTraveller/homePage.dart';
import '../View/NearestLocationScreen/locationScreen.dart';
import '../View/Profilescreen/userProfilescreen.dart';

class HomeController extends GetxController {
  var tabindex = 0.obs;

  // Define the pages for each destination
  var homePage = Homepage();  // Replace with your actual Home Page widget
  var nearestLocationPage = NearestLocationScreen();  // Replace with your actual Nearest Location Page widget
  var alertPage =Alertscreen();  // Replace with your actual Alert Page widget
  var profilePage = Userprofilescreen();  // Replace with your actual Profile Page widget

  // Method to change tab index
  void changeTabIndex(int index) {
    tabindex.value = index;
  }
}
