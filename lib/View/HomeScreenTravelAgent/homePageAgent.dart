import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/HomeScreenTravelAgent/addPackage.dart';
import 'package:tripmates/View/HomeScreenTravelAgent/detailsOfTravelCards.dart';
import 'package:tripmates/widgets/travel_card_citywise.dart';
import '../../controller/agentHomePageController.dart';

class Homepageagent extends StatelessWidget {
  Homepageagent({super.key});

  final AgentHomePageController _controller = Get.put(AgentHomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (_controller.travelPackages.isEmpty) {
          return const Center(child: Text("No packages available"));
        }
        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: _controller.travelPackages.length,
          itemBuilder: (context, index) {
            final package = _controller.travelPackages[index];
            return GestureDetector(
              onTap: () {
                Detailsoftravelcards(
                    image: package['image'] ?? '',
                    text: package['text'] ?? 'No Title',
                    description: package['description'] ?? 'No Description',
                    price: package['price'] ?? '0',
                    no_of_days: package['no_of_days'] ?? '0',
                    Stars: package['Stars'] ?? '0',
                );
              },
              child: TravelCardCitywise(
                image: package['image'] ?? '',
                text: package['text'] ?? 'No Title',
                description: package['description'] ?? 'No Description',
                price: package['price'] ?? '0',
                no_of_days: package['no_of_days'] ?? '0',
                stars: package['Stars'] ?? '0',
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.to(() => Addpackage());
          _controller.fetchPackagesFromFirebase();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
