// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
//
// class AlertAgentController extends GetxController{
//
// Future<void> createAgentAlert(String agentId, String type, String content) async {
//   await FirebaseFirestore.instance
//       .collection('users')
//       .doc(agentId)
//       .collection('notifications')
//       .add({
//     'type': type, // "message" or "rating"
//     'content': content,
//     'timestamp': FieldValue.serverTimestamp(),
//   });
// }
//
//
// Future<void> notifyAgentOnMessage(String agentId, String travelerName) async {
//   String message = "$travelerName sent you a message!";
//   await createAgentAlert(agentId, "message", message);
// }
//
// Future<void> notifyAgentOnRating(String agentId, String travelerName, int rating) async {
//   String message = "$travelerName gave you a $rating-star rating!";
//   await createAgentAlert(agentId, "rating", message);
// }
//
// }