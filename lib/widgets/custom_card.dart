import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../View/HomeScreenTraveller/packageDetailPage.dart';

class CustomCard extends StatelessWidget {
  final Map<String, String> package;

  const CustomCard({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 280,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      package["photoUrl"] ?? "",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    package["price"] ?? "",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                package["name"] ?? "",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                package["description"] ?? "",
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => PackageDetailPage(package: package));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    "Check",
                    style: TextStyle(color: Theme.of(context).colorScheme.surface),
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
