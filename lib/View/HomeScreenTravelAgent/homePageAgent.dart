// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:tripmates/View/HomeScreenTravelAgent/addPackage.dart';
// import 'package:tripmates/View/HomeScreenTravelAgent/detailsOfTravelCards.dart';
// import 'package:tripmates/widgets/travel_card_citywise.dart';
//
// class Homepageagent extends StatefulWidget {
//   const Homepageagent({super.key});
//
//   @override
//   State<Homepageagent> createState() => _HomepageagentState();
// }
//
// class _HomepageagentState extends State<Homepageagent> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   List<Map<String, String>> travelPackages = [];
//
//   void addPackage(Map<String, String> newPackage) {
//     setState(() {
//       travelPackages.add(newPackage);
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchPackagesFromFirebase();
//   }
//
//   Future<void> fetchPackagesFromFirebase() async {
//     User? user = _auth.currentUser;
//     if (user == null) return;
//
//     String userId = user.uid;
//
//     QuerySnapshot snapshot = await _firestore
//         .collection('users')
//         .doc(userId)
//         .collection('packages')
//         .orderBy('timestamp', descending: true)
//         .get();
//
//     setState(() {
//       travelPackages = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
//         color: Theme.of(context).secondaryHeaderColor,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 100,),
//
//                  GestureDetector(
//                    onTap: (){
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(builder: (context)=> Detailsoftravelcards(
//                              image:'assets/images/AppLogo-TripMates.png' ,
//                              text: 'Brazil For 5 Days',
//                              description: 'Travel Brazil with the best Crew,'
//                                  'Travel Brazil with the best Crew'
//                                  'Travel Brazil with the best Crew'
//                                  'Travel Brazil with the best Crew'
//                                  'Travel Brazil with the best Crew',
//                              price: '567',
//                              no_of_days: '5',
//                              Stars: '4.2'
//                          ))
//                      );
//                    },
//                    child: TravelCardCitywise(
//                        image:'assets/images/AppLogo-TripMates.png' ,
//                        text: 'Brazil For 5 Days',
//                         description: '',
//                        price: '567',
//                        no_of_days: '5',
//                        Stars: '4.2'
//                    ),
//                  ),
//
//               SizedBox(height: 20,),
//
//
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => Addpackage()),
//           );
//
//           fetchPackagesFromFirebase(); // Refresh the packages after adding a new one
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripmates/View/HomeScreenTravelAgent/addPackage.dart';
import 'package:tripmates/View/HomeScreenTravelAgent/detailsOfTravelCards.dart';
import 'package:tripmates/widgets/travel_card_citywise.dart';

class Homepageagent extends StatefulWidget {
  const Homepageagent({super.key});

  @override
  State<Homepageagent> createState() => _HomepageagentState();
}

class _HomepageagentState extends State<Homepageagent> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> travelPackages = [];

  @override
  void initState() {
    super.initState();
    fetchPackagesFromFirebase();
  }

  Future<void> fetchPackagesFromFirebase() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    String userId = user.uid;

    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('packages')
        .orderBy('timestamp', descending: true)
        .get();

    setState(() {
      travelPackages = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>?)
          .whereType<Map<String, dynamic>>()
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
        color: Theme.of(context).secondaryHeaderColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),

              // Displaying packages from Firebase
              ...travelPackages.map((package) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detailsoftravelcards(
                          image: package['image'] ?? 'assets/images/AppLogo-TripMates.png',
                          text: package['text'] ?? 'No Title',
                          description: package['description'] ?? 'No Description',
                          price: package['price'] ?? '0',
                          no_of_days: package['no_of_days'] ?? '0',
                          Stars: package['Stars'] ?? '0',
                        ),
                      ),
                    );
                  },
                  child: TravelCardCitywise(
                    image: package['image'] ?? '',
                    text: package['text'] ?? 'No Title',
                    description: package['description'] ?? 'No Description',
                    price: package['price'] ?? '0',
                    no_of_days: package['no_of_days'] ?? '0',
                    Stars: package['Stars'] ?? '0',
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addpackage()),
          );
          fetchPackagesFromFirebase(); // Refresh the packages after adding a new one
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
