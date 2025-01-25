import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_card.dart';
import '../../widgets/travelGuide_card.dart';
import '../NearestLocationScreen/locationScreen.dart';

class Homepageagent extends StatefulWidget {
  const Homepageagent({super.key});

  @override
  State<Homepageagent> createState() => _HomepageagentState();
}

class _HomepageagentState extends State<Homepageagent> {
  @override
  Widget build(BuildContext context) {
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
                        Icon(Icons.location_pin),
                        Spacer(),
                        SizedBox(height: 50),
                        IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
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
