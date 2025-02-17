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
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent, // Makes the background transparent
        elevation: 0, // Removes any shadow effect
        flexibleSpace: Center(
          child: Image.asset('assets/images/AppLogo-TripMates.png'),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Line height
          child: Container(
            color: Theme.of(context).primaryColor, // Color of the line
            height: 2.0, // Line thickness
          ),
        ),
      ),

      body: Obx(() {
        if (_controller.travelPackages.isEmpty) {
          return const Center(
              child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: _controller.travelPackages.length,
          itemBuilder: (context, index) {
            final package = _controller.travelPackages[index];
            return GestureDetector(
              onTap: () {
                Get.to(()=>Detailsoftravelcards(
                    image: package['image'] ?? '',
                    text: package['text'] ?? 'No Title',
                    description: package['description'] ?? 'No Description',
                    price: package['price'] ?? '0',
                    no_of_days: package['no_of_days'] ?? '0',
                    Stars: package['Stars'] ?? '0',
                ), );

              },
              child: TravelCardCitywise(
                image: package['image'] ?? '',
                text: package['text'] ?? 'No Title',
                description: package['description'] ?? 'No Description',
                price: package['price'] ?? '0',
                no_of_days: package['no_of_days'] ?? '0',
                stars: package['Stars'] ?? '0', packageId: '',
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
