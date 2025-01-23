import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/SignUpScreen/SignUpScreen.dart';
import 'package:tripmates/controller/loginpageController.dart';
import 'package:tripmates/services/authservices.dart';

class MyLoginPage extends StatefulWidget {

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final controller = Get.find<LoginPageController>();
 // Inject LoginController
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
            () => Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 70),
                  Column(
                    children: [
                      SizedBox(width: 120),
                      Image.asset(
                        'assets/images/AppLogo-TripMates.png',
                        height: 200,
                        width: 100,
                        color: Colors.blueGrey[900],
                      ),
                      Text('Welcome Back! We missed You'),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: controller.usernameController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Enter your username',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: controller.passwordController,
                      obscureText: true,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forgot Password  '),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 70),
                    child: ElevatedButton(
                      onPressed: controller.signin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("OR CONTINUE WITH"),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 120),
                      GestureDetector(
                        onTap: () => AuthServices().signInWithGoogle(),
                        child: Image.asset(
                          'assets/images/img_1.png',
                          height: 100,
                          width: 50,
                        ),
                      ),
                      SizedBox(width: 30),
                      Image.asset(
                        'assets/images/img_2.png',
                        height: 100,
                        width: 50,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not a User,'),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => Get.to(() => SignUpScreen()),
                        child: Text(
                          'Register Now',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (controller.isLoading.value)
              Center(child: CircularProgressIndicator()), // Show loading spinner when signing in
          ],
        ),
      ),
    );
  }
}
