import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          SizedBox(height: 200,),
          Center(
            child: Text(
              'TripMates',
              style: TextStyle(fontSize: 30,color: Theme.of(context).colorScheme.primary,),
            ),
          ),
        ],
      ),
    );
  }
}
