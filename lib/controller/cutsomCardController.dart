import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CustomCardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<User?> user = FirebaseAuth.instance.currentUser.obs;

  final RxList<Map<String, String>> packages = <Map<String, String>>[].obs;



  @override
  void onInit() {
    super.onInit();
    fetchPackagesCardData();
  }

  void fetchPackagesCardData() async {
    if (user.value == null) return;

    try {
      // Fetch all users with the "Travel Agent" role
      QuerySnapshot agentQuerySnapshot = await _firestore
          .collection("users")
          .where("role", isEqualTo: "Travel Agent")
          .get();

      for (var agent in agentQuerySnapshot.docs) {
        // Ensure correct fetching of the agent's name and ID
        Map<String, dynamic> agentData = agent.data() as Map<String, dynamic>;
        String agentName = agentData["name"] ?? "huehue";
        String agentId = agent.id;

        print("Fetched Agent: $agentName, ID: $agentId");

        // Listen for package updates within each agent's packages subcollection
        _firestore
            .collection("users")
            .doc(agentId)
            .collection("packages")
            .snapshots()
            .listen((packageSnapshot) {
          if (packageSnapshot.docs.isNotEmpty) {
            for (var doc in packageSnapshot.docs) {
              Map<String, dynamic> data = doc.data();

              packages.add({
                "photoUrl": data["image"] ?? "",
                "name": data["text"] ?? "",
                "description": data["description"] ?? "",
                "price": data["price"] ?? "",
                "agentName": agentName, // Correct agent name
                "agentId": agentId,
              });

              print("Package added: ${data["text"]} by $agentName");
            }
          } else {
            print("No packages found for Travel Agent: $agentId");
          }
        });
      }
    } catch (e) {
      print("Error fetching packages: $e");
    }
  }

}