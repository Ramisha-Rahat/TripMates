import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class  Addpackage extends StatefulWidget {
   Addpackage({super.key});

  @override
  State<Addpackage> createState() => _AddpackageState();
}

class _AddpackageState extends State<Addpackage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController textController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController noOfDaysController = TextEditingController();
  final TextEditingController starsController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPackageToFirebase() async {
    User? user = _auth.currentUser; // Get current logged-in user
    if (user == null) return; // If no user, do nothing

    String userId = user.uid; // Get user ID

    Map<String, dynamic> newPackage = {
      'image': 'assets/images/AppLogo-TripMates.png',
      'text': textController.text,
      'description': descriptionController.text,
      'price': priceController.text,
      'no_of_days': noOfDaysController.text,
      'Stars': starsController.text,
      'timestamp': FieldValue.serverTimestamp(), // Store time of creation
    };

    // Store package inside travel agent's document
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('packages')
        .add(newPackage);

    Navigator.pop(context); // Go back to homepage after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Travel Package")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: textController,
                decoration: InputDecoration(labelText: "Package Title"),
                validator: (value) => value!.isEmpty ? "Enter title" : null,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) => value!.isEmpty ? "Enter description" : null,
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter price" : null,
              ),
              TextFormField(
                controller: noOfDaysController,
                decoration: InputDecoration(labelText: "Number of Days"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter number of days" : null,
              ),
              TextFormField(
                controller: starsController,
                decoration: InputDecoration(labelText: "Stars"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter rating" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addPackageToFirebase();
                  }
                },
                child: Text("Add Package"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}