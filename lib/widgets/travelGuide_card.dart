import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/HomeScreenTraveller/agentDetailPage.dart';

class TravelguideCard extends StatelessWidget {
  final int rating;
  final Map<String, dynamic> user; // Updated to accept dynamic

  const TravelguideCard({
    super.key,
    required this.user,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8, // Adds shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Container(
          width: 250,
          padding: const EdgeInsets.all(10), // Padding inside the card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      user["photoUrl"] ?? "",
                      height: 80,
                      width: 100,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                    ),
                  ),
                  Row(
                    children: List.generate(
                      rating,
                          (index) =>
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                user["name"] ?? "Unknown",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                user["description"] ?? "No bio available",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the agent detail page and pass the user data
                    Get.to(() => AgentDetailPage(agent: user));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    "See Details",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
