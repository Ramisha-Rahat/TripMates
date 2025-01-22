import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/CreateProfile/creatingProfileScreen.dart';
import 'package:tripmates/bindings/creatingProfileScreenBinding.dart';
import 'package:tripmates/utils/theme/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          page: () => CreatingProfileScreen(),
          binding: creatingProfileScreenBinding(),
          //     SignUpScreen(),
          // binding:SignUpBinding(),
        ),
      ],
    );
  }
}