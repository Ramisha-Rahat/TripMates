import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/LoginScreen/LoginPage.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/travelGuide_card.dart';
import '../NearestLocationScreen/locationScreen.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => MyLoginPage()); // Navigate to MyLoginPage and clear the navigation stack
  }


  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    // final String? photoUrl = user?.photoURL; // Get the user's profile picture URL
    //  final String? displayName = user?.displayName; // Get the user's display name

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

                        // IconButton(onPressed: () {},
                        //     icon: Icon(Icons.person),
                        // ),

                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     if (photoUrl != null) // Display profile picture if available
                        //       CircleAvatar(
                        //         backgroundImage: NetworkImage(photoUrl),
                        //         radius: 20,
                        //       ),
                        //  SizedBox(height: 20),
                        // Text('${user}', style: TextStyle(fontSize: 10),),
                        //],
                        //),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.surface),
                        hintText: 'Type a place to search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
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
                      'Find the locations nearest to you',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 18),
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
                          height: 290,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: CustomCard(
                                  image: 'assets/images/img.png',
                                  text: 'Card $index',
                                  description: 'Description for card $index',
                                  price: '${20 + index * 5}',
                                ),
                              );
                            },
                          ),
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
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TravelguideCard(
                                  image: 'assets/images/camera.png',
                                  text: 'Travel Agent $index',
                                  description: 'Description for agent $index',
                                  icon: Icons.reviews,
                                  Rating: 5,
                                ),
                              );
                            },
                          ),
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
