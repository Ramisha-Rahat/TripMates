import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LocationPageController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<User?> user = FirebaseAuth.instance.currentUser.obs;
  final RxString searchQuery = ''.obs; // Observable search query

  final RxList<Map<String, String>> packages = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPackagesCardData();
  }

  void fetchPackagesCardData() async {
    if (user.value == null) return;

    try {

      QuerySnapshot agentQuerySnapshot = await _firestore
          .collection("users")
          .where("role", isEqualTo: "Travel Agent")
          .get();

      for (var agentDoc in agentQuerySnapshot.docs) {
        _firestore
            .collection("users")
            .doc(agentDoc.id)
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
              });
            }
          } else {
            print("No packages found for Travel Agent: ${agentDoc.id}");
          }
        });
      }
    } catch (e) {
      print("Error fetching packages: $e");
    }
  }
}