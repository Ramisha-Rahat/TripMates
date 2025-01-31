import 'package:flutter/material.dart';

class Communityscreen extends StatelessWidget {
  const Communityscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meassages')),
        body: Container(
          child: Center(
            child: Text('Community'),
          ),
        )
    );
  }
}