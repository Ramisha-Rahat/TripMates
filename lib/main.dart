import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/LoginScreen/LoginPage.dart';
import 'package:tripmates/bindings/loginPageBinding.dart';
import 'package:tripmates/controller/MainWrapperController.dart';
import 'package:tripmates/controller/agentHomePageController.dart';
import 'package:tripmates/controller/agentProfileController.dart';
import 'package:tripmates/controller/alertAgentConroller.dart';
import 'package:tripmates/controller/chatController.dart';
import 'package:tripmates/controller/communityPageController.dart';
import 'package:tripmates/controller/cutsomCardController.dart';
import 'package:tripmates/controller/loginpageController.dart';
import 'package:tripmates/controller/signupController.dart';
import 'package:tripmates/controller/travelGuideCardController.dart';
import 'package:tripmates/controller/agentCommunityController.dart';
import 'package:tripmates/controller/locationPageController.dart';
import 'package:tripmates/controller/userProfileController.dart';
import 'package:tripmates/services/authservices.dart';
import 'package:tripmates/utils/theme/theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Firebase Messaging permissions
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();

  // ✅ Register all services and controllers
  Get.put(AuthServices()); // Ensure AuthServices is available first
  Get.put(UserProfileController());
  Get.put(MainWrapperController());
  Get.put(AgentProfileController());
  Get.put(AgentHomePageController());
  Get.put(SignUpController());
  Get.put(CustomCardController());
  Get.put(TravelGuidCardController());
  Get.put(LoginPageController());
  Get.put(LocationPageController());
  Get.put(CommunityPageController());
  Get.put(ChatController());

  runApp(const MyApp()); // ✅ Only call runApp() once
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TripMates',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => MyLoginPage(),
          binding: LoginPageBinding(),
        ),
      ],
    );
  }
}
