import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/LoginScreen/LoginPage.dart';
import 'package:tripmates/controller/travelGuideCardController.dart';
import '../../controller/cutsomCardController.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/travelGuide_card.dart';
import '../NearestLocationScreen/locationScreen.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() =>
        MyLoginPage()); // Navigate to MyLoginPage and clear the navigation stack
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    // Future<void> sendNotificationToAgent(String agentId, String userName, String packageName) async {
    //   FirebaseFirestore _firestore = FirebaseFirestore.instance;
    //
    //   await _firestore.collection('users').doc(agentId).collection('notifications').add({
    //     'message': "$userName viewed your package: $packageName",
    //     'timestamp': FieldValue.serverTimestamp(),
    //     'isRead': false,
    //   });
    // }

    final CustomCardController _controler = Get.put(CustomCardController());
    final TravelGuidCardController _controller =
        Get.put(TravelGuidCardController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        SizedBox(height: 50),
                        Text(
                          'Location',
                          style: TextStyle(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.location_pin),
                        SizedBox(height: 50),
                        IconButton(
                            onPressed: () {
                              signOut();
                            },
                            icon: Icon(Icons.logout)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Find your favourite location yourself',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Transform.rotate(
                      angle: 0.785398,
                      child: IconButton(
                          onPressed: () {
                            Get.to(NearestLocationScreen());
                          },
                          icon: Icon(
                            Icons.navigation,
                            size: 25,
                            color: Theme.of(context).colorScheme.surface,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'The most relevant',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 300,
                          child: Obx(() {
                            if (_controler.packages.isEmpty) {
                              return Text('no data');
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _controler.packages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: CustomCard(
                                    package: _controler.packages[
                                        index], // Pass the package correctly
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Your Tour Guides',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 250,
                          child: Obx(() {
                            if (_controller.users.isEmpty) {
                              return Text('no data');
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _controller.users.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: TravelguideCard(
                                    user: _controller.users[index], // Ensure _controller.users is used
                                    rating: 5,
                                  ),

                                );
                              },
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
