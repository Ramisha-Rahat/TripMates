// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AlertController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   RxList<Map<String, dynamic>> alerts = <Map<String, dynamic>>[].obs;
//
//   // Fetch alerts for the logged-in user
//   void fetchAlerts(String userId) {
//     _firestore
//         .collection('alerts')
//         .where('userId', isEqualTo: userId)
//         .orderBy('timestamp', descending: true)
//         .snapshots()
//         .listen((snapshot) {
//       alerts.value = snapshot.docs.map((doc) {
//         var data = doc.data();
//         data['id'] = doc.id;
//         return data;
//       }).toList();
//     });
//   }
//
//   // Mark an alert as seen
//   Future<void> markAlertAsSeen(String alertId) async {
//     await _firestore.collection('alerts').doc(alertId).update({'seen': true});
//   }
// }
