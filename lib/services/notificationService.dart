import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationService {
  final String _serverKey = 'YOUR_SERVER_KEY';

  Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
  }) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$_serverKey',
        },
        body: jsonEncode({
          'to': token,
          'notification': {
            'title': title,
            'body': body,
          },
          'priority': 'high',
        }),
      );
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}
