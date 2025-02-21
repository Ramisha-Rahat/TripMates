import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/controller/locationPageController.dart';
import '../../widgets/custom_card.dart';

class NearestLocationScreen extends StatelessWidget {
  NearestLocationScreen({super.key});

  final LocationPageController _controller = Get.put(LocationPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('All the packages and tours'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                _controller.searchQuery.value = value.toLowerCase(); // Update search query
              },
              decoration: InputDecoration(
                hintText: "Search for places to visit...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.primary,),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),

          // Packages List
          Expanded(
            child: Obx(() {
              // Filter packages based on search query
              final filteredPackages = _controller.packages.where((package) {
                final name = package["name"]?.toLowerCase() ?? "";
                return name.contains(_controller.searchQuery.value);
              }).toList();

              if (filteredPackages.isEmpty) {
                return const Center(child: Text('No matching packages found'));
              }

              return ListView.builder(
                itemCount: filteredPackages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CustomCard(
                      package: filteredPackages[index], // Show filtered packages
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
