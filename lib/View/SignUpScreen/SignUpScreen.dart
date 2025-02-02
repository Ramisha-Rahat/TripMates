import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/LoginScreen/LoginPage.dart';
import 'package:tripmates/controller/signupController.dart';
import 'package:tripmates/widgets/custom_textFields.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {

    final controller = Get.find<SignUpController>(); // Access the controller

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Column(
                children: [
                  SizedBox(width: 120),
                  Image.asset(
                    'assets/images/AppLogo-TripMates.png',
                    height: 150,
                    width: 100,
                    color: Colors.blueGrey[900],
                  ),
                  Text('Welcome! Register Yourself'),
                ],
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: controller.emailController,
                label: 'Username',
                hint: 'Enter your username',
                icon: Icons.person,
              ),
              SizedBox(height: 10.0),
              CustomTextField(
                controller: controller.passwordController,
                label: 'Password',
                hint: 'Enter your password',
                icon: Icons.lock,
                obscureText: true,
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: controller.rePasswordController,
                label: 'Re-enter Password',
                hint: 'Enter your password again',
                icon: Icons.lock,
                obscureText: true,
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
                  onPressed: () => controller.register(),
                  // Call register method
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Obx(() =>
                  controller.isLoading.value
                      ? CircularProgressIndicator() // Show loading indicator
                      : Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
                ),
              ),
              SizedBox(height: 10.0),
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
                    onTap: () {
                      // Add Google SignIn logic here
                    },
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
                  Text('Already a User,'),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => MyLoginPage()); // Navigate to login page
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}