import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/alertPageController.dart';

class AlertScreen extends StatelessWidget {
  final String userId; // Pass the logged-in user ID
  AlertScreen({Key? key, required this.userId}) : super(key: key);

//  final AlertController alertController = Get.put(AlertController());

  @override
  Widget build(BuildContext context) {
    // alertController.fetchAlerts(userId);

    return Scaffold(
      appBar: AppBar(title: Text('Alerts')),
      // body: Obx(() {
      //   if (alertController.alerts.isEmpty) {
      //     return Center(child: Text('No alerts available.'));
      //   }
      //   return ListView.builder(
      //     itemCount: alertController.alerts.length,
      //     itemBuilder: (context, index) {
      //       var alert = alertController.alerts[index];
      //       return Card(
      //         margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //         child: ListTile(
      //           title: Text(alert['content'], style: TextStyle(fontWeight: FontWeight.bold)),
      //           subtitle: Text(alert['timestamp'].toDate().toString()),
      //           trailing: alert['seen']
      //               ? Icon(Icons.check_circle, color: Colors.green)
      //               : Icon(Icons.notifications_active, color: Colors.red),
      //           onTap: () {
      //             alertController.markAlertAsSeen(alert['id']);
      //           },
      //         ),
      //       );
      //     },
      //   );
      // }),
    );
  }
}
