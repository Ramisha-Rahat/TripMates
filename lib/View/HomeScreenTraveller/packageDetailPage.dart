import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/View/communityScreen/ChatScreen.dart';

class PackageDetailPage extends StatelessWidget {
  final Map<String, String> package;

  const PackageDetailPage({super.key, required this.package});

  // Dynamic inclusions based on the trip duration
  List<String> getTripInclusions(int days) {
    if (days <= 3) {
      return ['Room with Breakfast', 'Lunch & Dinner', 'Local Sightseeing'];
    } else if (days <= 5) {
      return ['Premium Room', 'All Meals Included', 'Guided Tours', 'Airport Pickup'];
    } else {
      return ['Luxury Suite', 'All Meals & Beverages', 'Private Tours', 'Spa Access', 'VIP Transfers'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final int days = int.tryParse(package['no_of_days'] ?? '0') ?? 0;
    final inclusions = getTripInclusions(days);

    return Scaffold(
      appBar: AppBar(
        title: Text(package['name'] ?? 'Package Details'),
        centerTitle: true,
        backgroundColor:Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Package Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                package['photoUrl'] ?? '',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 200),
              ),
            ),
            const SizedBox(height: 20),

            // Package Title
            Text(
              package['name'] ?? '',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              package['description'] ?? 'No description available.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            const SizedBox(height: 20),

            // Price
            Row(
              children: [
                const Icon(Icons.attach_money, color: Colors.green, size: 28),
                Text(
                  "${package['price'] ?? ''}",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Travel Agent Info
            Row(
              children: [
                const Icon(Icons.person, color: Colors.blue, size: 24),
                const SizedBox(width: 8),
                Text(
                  "Travel Agent: ${package['agentName'] ?? 'Unknown'}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.blue),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Trip Inclusions
            const Text(
              'What’s Included:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: inclusions.map((inclusion) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.teal),
                    const SizedBox(width: 8),
                    Text(inclusion, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              )).toList(),
            ),

            const SizedBox(height: 40),

            // Start Chat Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final receiverId = package['agentId'] ?? '';
                  final receiverEmail = package['agentEmail'] ?? '';

                  if (receiverId.isNotEmpty && receiverEmail.isNotEmpty) {
                    Get.to(() => ChatScreen(
                       receiverEmail: receiverEmail, receiverId: receiverId,
                    ));
                  } else {
                    Get.snackbar('Error', 'Agent information is missing!');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Start Chat",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
