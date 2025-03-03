
import 'package:get/get.dart';
import 'package:tripmates/View/AlertScreen/alertScreen.dart';
import 'package:tripmates/View/CreateProfile/creatingProfileScreen.dart';
import 'package:tripmates/View/HomeScreenTravelAgent/homePageAgent.dart';
import 'package:tripmates/View/LoginScreen/LoginPage.dart';
import 'package:tripmates/View/NearestLocationScreen/locationScreen.dart';
import 'package:tripmates/View/Profilescreen/agentProfileScreen.dart';
import 'package:tripmates/View/Profilescreen/userProfilescreen.dart';
import 'package:tripmates/View/SignUpScreen/SignUpScreen.dart';
import 'package:tripmates/View/communityScreen/communityScreen.dart';
import 'package:tripmates/routes/route_names.dart';

import '../View/HomeScreenTraveller/homePage.dart';

class AppRoutes {

  static appRoutes() => [
    GetPage(name: RouteName.loginView, page: () =>  MyLoginPage(),) ,
    GetPage(name: RouteName.signupView, page: () => SignUpScreen(),),
    GetPage(name: RouteName.homePageView, page: () => Homepage(),),
    GetPage(name: RouteName.nearestLocationScreen, page: () => NearestLocationScreen(),),
    GetPage(name: RouteName.userProfileScreen, page: () => UserProfileScreen(),),
    GetPage(name: RouteName.agentProfileScreen, page: () => Agentprofilescreen(),),
    GetPage(name: RouteName.alertScreen, page: () => AlertScreen(userId: '',),),
    GetPage(name: RouteName.communityScreen, page: () => CommunityScreen()),
    GetPage(name: RouteName.creatingProfileScreens, page: ()=> CreatingProfileScreen()),
    GetPage(name: RouteName.homePageAgent, page: ()=> Homepageagent()),

  ];

}