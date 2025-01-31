import 'package:flutter/material.dart';
import 'package:tripmates/widgets/notification_widget.dart';

class Bookings extends StatelessWidget {
  const Bookings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: Center(
        child: Column(
          children: [
               NotificationWidget(text1: 'User has liked your Travel Package', text2: 'User hase favourited you')
          ],
        ),
      ),
    );
  }
}
