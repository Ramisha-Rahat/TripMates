import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AgentHomePageController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController textController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController noOfDaysController = TextEditingController();
  final TextEditingController starsController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Rx<User?> user = FirebaseAuth.instance.currentUser.obs;
  final RxString photoUrl = ''.obs;

  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> travelPackages = <Map<String, dynamic>>[].obs;

  final ImagePicker _picker = ImagePicker();

  // Pick Image and Upload to Cloudinary
  Future<void> pickAndUploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String imageUrl = await uploadImageToCloudinary(imageFile);

      if (imageUrl.isNotEmpty) {
        photoUrl.value = imageUrl; // Update UI instantly
        Get.snackbar("Success", "Image selected successfully!");
      }
    }
  }

  Future<String> uploadImageToCloudinary(File imageFile) async {
    String cloudName = "dlc8c60ap";
    String uploadPreset = "example";

    var url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    var request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      return jsonResponse['secure_url']; // Cloudinary returns the uploaded image URL
    } else {
      print('Failed to upload image. Status Code: ${response.statusCode}');
      return '';
    }
  }

  // Upload Package to Firebase
  Future<void> uploadImageAndSavePackage() async {
    if (photoUrl.value.isEmpty) {
      Get.snackbar("Error", "Please select an image");
      return;
    }

    isLoading.value = true;

    Map<String, dynamic> newPackage = {
      'image': photoUrl.value,
      'text': textController.text,
      'description': descriptionController.text,
      'price': priceController.text,
      'no_of_days': noOfDaysController.text,
      'Stars': starsController.text,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await _firestore.collection('users')
        .doc(user.value?.uid)
        .collection('packages')
        .add(newPackage);

    Get.snackbar("Success", "Package added successfully!");
    fetchPackagesFromFirebase();
    clearFields();
    Get.back();

    isLoading.value = false;
  }

  // Fetch Packages from Firebase
  Future<void> fetchPackagesFromFirebase() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('packages')
        .orderBy('timestamp', descending: true)
        .get();

    travelPackages.assignAll(
      snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList(),
    );
  }

  // Delete Package
  Future<void> deletePackage(String packageId) async {
    await _firestore.collection('users')
        .doc(user.value?.uid)
        .collection('packages')
        .doc(packageId)
        .delete();

    Get.snackbar("Deleted", "Package has been removed");
    fetchPackagesFromFirebase();
  }

  void clearFields() {
    textController.clear();
    descriptionController.clear();
    priceController.clear();
    noOfDaysController.clear();
    starsController.clear();
    photoUrl.value = "";
  }
}
