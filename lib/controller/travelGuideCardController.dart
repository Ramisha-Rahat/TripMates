// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
//
// class TravelGuidCardController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchTravelAgents();
//   }
//
//   void fetchTravelAgents() {
//     _firestore
//         .collection("users")
//         .where("role", isEqualTo: "Travel Agent")
//         .snapshots()
//         .listen((querySnapshot) {
//       if (querySnapshot.docs.isNotEmpty) {
//         users.value = querySnapshot.docs.map((doc) {
//           final data = doc.data();
//           return {
//             "id": doc.id,
//             "name": data["name"] ?? "No Name",
//             "description": data["bio"] ?? "No Description",
//             "photoUrl": data["photoUrl"] ?? "",
//           };
//         }).toList();
//       } else {
//         users.clear();
//       }
//     });
//   }
//
//   Future<List<Map<String, dynamic>>> fetchAgentPackages(String agentId) async {
//     final snapshot = await _firestore
//         .collection("packages")
//         .where("agentId", isEqualTo: agentId)
//         .get();
//
//     return snapshot.docs.map((doc) => doc.data()).toList();
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TravelGuidCardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTravelAgents();
  }

  void fetchTravelAgents() {
    _firestore
        .collection("users")
        .where("role", isEqualTo: "Travel Agent")
        .snapshots()
        .listen((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        users.value = querySnapshot.docs.map((doc) {
          final data = doc.data();
          return {
            "id": doc.id, // Ensure correct agent ID
            "name": data["name"] ?? "No Name",
            "description": data["bio"] ?? "No Description",
            "photoUrl": data["photoUrl"] ?? "",
          };
        }).toList();
      } else {
        users.clear();
      }
    });
  }
}
