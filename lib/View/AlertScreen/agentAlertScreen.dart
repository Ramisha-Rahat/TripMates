import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TravelAgentAlertScreen extends StatelessWidget {
  final String agentId;

  TravelAgentAlertScreen({required this.agentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agent Alerts")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('alerts')
            .doc(agentId)
            .collection('notifications')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          var alerts = snapshot.data!.docs;

          if (alerts.isEmpty) {
            return Center(child: Text("No alerts yet!"));
          }

          return ListView.builder(
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              var alert = alerts[index];
              return ListTile(
                title: Text(alert['content']),
                subtitle: Text(alert['type']),
                leading: Icon(alert['type'] == "message" ? Icons.message : Icons.star),
              );
            },
          );
        },
      ),
    );
  }
}
