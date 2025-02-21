import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TravelGuidCardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<User?> user = FirebaseAuth.instance.currentUser.obs;

  final RxList<Map<String, String>> users = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTravelAgents();
  }

  void fetchTravelAgents() async {
    FirebaseFirestore.instance
        .collection("users")
        .where("role", isEqualTo: "Travel Agent")
        .snapshots()
        .listen((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, String>> agentsList = [];

        for (var doc in querySnapshot.docs) {
          agentsList.add({
            "name": doc.data()["name"] ?? "No Name",
            "description": doc.data()["bio"] ?? "No Description",
            "photoUrl": doc.data()["photoUrl"] ?? "",
          });
        }

        users.value = agentsList;
      } else {
        users.clear();
        print("No Travel Agents found.");
      }
    });
  }
}
