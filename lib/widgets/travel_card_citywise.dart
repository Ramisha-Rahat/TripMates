import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../View/HomeScreenTravelAgent/addPackage.dart';
import '../controller/agentHomePageController.dart';

class TravelCardCitywise extends StatelessWidget {
  final String image;
  final String text;
  final String no_of_days;
  final String description;
  final String stars;
  final String price;
  final String packageId;

  TravelCardCitywise({
    super.key,
    required this.image,
    required this.text,
    required this.description,
    required this.price,
    required this.no_of_days,
    required this.stars, required this.packageId,
  });

  @override
  Widget build(BuildContext context) {

    final AgentHomePageController _controller = Get.put(AgentHomePageController());

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: image.isNotEmpty
                    ? Image.network(
                  image,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/AppLogo-TripMates.png', // Fallback image
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                )
                    : Image.asset(
                  'assets/images/AppLogo-TripMates.png', // If URL is empty, show default image
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Details Section
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Description
                    Text(
                      description,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Row for Stars, Price & No. of Days
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Stars
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              stars,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        // Price
                        Text(
                          "\$$price",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),

                        // No. of Days
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 16, color: Colors.blueGrey),
                            const SizedBox(width: 4),
                            Text(
                              "$no_of_days Days",
                              style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ],

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: (){
                                _controller.edit_package({
                                      'id': packageId,
                                      'text': text,
                                      'description': description,
                                      'price': price,
                                      'no_of_days': no_of_days,
                                      'Stars': stars,
                                      'image': image,
                                    });
                                Get.to(() => Addpackage());
                              },
                              icon: Icon(Icons.edit,)),
                         IconButton(
                             onPressed: (){
                               _controller.deletePackage(packageId);
                             },
                             icon: Icon(Icons.delete)),
                        ]
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
