import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/LoginScreen/LoginPage.dart';
import 'package:tripmates/bindings/loginPageBinding.dart';
import 'package:tripmates/controller/MainWrapperController.dart';
import 'package:tripmates/controller/agentHomePageController.dart';
import 'package:tripmates/controller/agentProfileController.dart';
import 'package:tripmates/controller/signupController.dart';
import 'package:tripmates/utils/theme/theme.dart';
import 'controller/userProfileController.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(UserProfileController());
  Get.put(MainWrapperController());
  Get.put(AgentProfileController());
  Get.put(AgentHomePageController());
  Get.put(SignUpController());

  runApp(const MyApp());
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